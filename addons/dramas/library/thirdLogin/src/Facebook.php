<?php

namespace addons\dramas\library\thirdLogin\src;

use addons\dramas\library\thirdLogin\User;
use GuzzleHttp\RequestOptions;

/**
 * @see https://developers.facebook.com/docs/graph-api [Facebook - Graph API]
 */
class Facebook extends Base
{
    public const NAME = 'facebook';

    protected string $graphUrl = 'https://graph.facebook.com';

    protected string $version = 'v18.0';

    protected array $fields = ['first_name', 'last_name', 'email', 'gender', 'verified','picture'];

    protected array $scopes = ['email', 'public_profile'];

    protected bool $popup = false;

    protected function getAuthUrl(): string
    {
        return $this->buildAuthUrlFromBase('https://www.facebook.com/'.$this->version.'/dialog/oauth');
    }

    protected function getTokenUrl(): string
    {
        return $this->graphUrl.'/oauth/access_token';
    }

    public function tokenFromCode(string $code): array
    {
        $response = $this->getHttpClient()->get($this->getTokenUrl(), [
            RequestOptions::QUERY => $this->getTokenFields($code),
        ]);

        return $this->normalizeAccessTokenResponse($response->getBody());
    }

    protected function getUserByToken(string $token, ?array $query = []): array
    {
        $appSecretProof = \hash_hmac('sha256', $token, $this->config['client_secret'] ?? null);

        $response = $this->getHttpClient()->get($this->graphUrl.'/'.$this->version.'/me', [
            RequestOptions::QUERY => [
                'access_token' => $token,
                'appsecret_proof' => $appSecretProof,
                'fields' => $this->formatScopes($this->fields, $this->scopeSeparator),
            ],
            RequestOptions::HEADERS => [
                'Accept' => 'application/json',
            ],
        ]);

        return $this->fromJsonBody($response);
    }

    protected function mapUserToObject(array $user)
    {
        $userId = $user['id'] ?? null;
        $avatarUrl = $this->graphUrl.'/'.$this->version.'/'.$userId.'/picture';

        $firstName = $user['first_name'] ?? null;
        $lastName = $user['last_name'] ?? null;

        return new User([
            'id' => $user['id'] ?? null,
            'nickname' => $firstName.' '.$lastName,
            'email' => $user['email'] ?? null,
            'avatar' => $userId ? $avatarUrl.'?type=normal' : null,
            'avatar_original' => $userId ? $avatarUrl.'?width=1920' : null,
        ]);
    }

    protected function getCodeFields(): array
    {
        $fields = parent::getCodeFields();

        if ($this->popup) {
            $fields['display'] = 'popup';
        }

        return $fields;
    }

    public function fields(array $fields): self
    {
        $this->fields = $fields;

        return $this;
    }

    public function asPopup(): self
    {
        $this->popup = true;

        return $this;
    }
}
