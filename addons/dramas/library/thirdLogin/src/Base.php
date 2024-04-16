<?php

namespace addons\dramas\library\thirdLogin\src;

use GuzzleHttp\Client as GuzzleClient;
use GuzzleHttp\Utils;
use Psr\Http\Message\MessageInterface;
use Psr\Http\Message\StreamInterface;

abstract class Base
{
    public const NAME = null;

    protected ?string      $state = null;

    protected              $config;

    protected ?string      $redirectUrl;

    protected array        $parameters = [];

    protected array        $scopes = [];

    protected string       $scopeSeparator = ',';

    protected GuzzleClient $httpClient;

    protected array        $guzzleOptions = [];

    protected int          $encodingType = PHP_QUERY_RFC1738;

    protected string       $expiresInKey = 'expires_in';

    protected string       $accessTokenKey = 'access_token';

    protected string       $refreshTokenKey = 'refresh_token';

    public function __construct(array $config)
    {
        $this->config = $config;
        // set scopes
        if (isset($this->config['scopes']) && is_array($this->config['scopes'])) {
            $this->scopes = $this->config['scopes'];
        } elseif (isset($this->config['scopes']) && is_string($this->config['scopes'])) {
            $this->scopes = [$this->config['scopes']];
        }
        // normalize CLIENT_ID
        if (! isset($this->config['client_id'])) {
            $id = $this->config['app_id'] ?? null;
            if (null != $id) {
                $this->config['client_id'] = $id;
            }
        }
        // normalize CLIENT_SECRET
        if (! isset($this->config['client_secret'])) {
            $secret = $this->config['app_secret'] ?? null;
            if (null != $secret) {
                $this->config['client_secret'] = $secret;
            }
        }
        // normalize 'redirect_url'
        if (! isset($this->config['redirect_url'])) {
            $this->config['redirect_url'] = $this->config['redirect'] ?? null;
        }
        $this->redirectUrl = $this->config['redirect_url'];
    }

    abstract protected function getAuthUrl(): string;

    abstract protected function getTokenUrl(): string;

    abstract protected function getUserByToken(string $token): array;

    public function redirect(?string $redirectUrl = null): string
    {
        if (! empty($redirectUrl)) {
            $this->withRedirectUrl($redirectUrl);
        }

        return $this->getAuthUrl();
    }

    public function userFromCode(string $code)
    {
        $tokenResponse = $this->tokenFromCode($code);

        $user = $this->userFromToken($tokenResponse[$this->accessTokenKey]);

        return $user->setRefreshToken($tokenResponse[$this->refreshTokenKey] ?? null)
            ->setExpiresIn($tokenResponse[$this->expiresInKey] ?? null)
            ->setTokenResponse($tokenResponse);
    }

    public function userFromToken(string $token)
    {
        $user = $this->getUserByToken($token);

        return $this->mapUserToObject($user)->setProvider($this)->setRaw($user)->setAccessToken($token);
    }

    public function tokenFromCode(string $code): array
    {
        $response = $this->getHttpClient()->post(
            $this->getTokenUrl(),
            [
                'form_params' => $this->getTokenFields($code),
                'headers' => [
                    'Accept' => 'application/json',
                ],
            ]
        );

        return $this->normalizeAccessTokenResponse((string) $response->getBody());
    }

    public function refreshToken(string $refreshToken)
    {
        throw new \Exception('refreshToken does not support.');
    }

    public function withRedirectUrl(string $redirectUrl)
    {
        $this->redirectUrl = $redirectUrl;

        return $this;
    }

    public function withState(string $state)
    {
        $this->state = $state;

        return $this;
    }

    public function scopes(array $scopes)
    {
        $this->scopes = $scopes;

        return $this;
    }

    public function with(array $parameters)
    {
        $this->parameters = $parameters;

        return $this;
    }

    public function getConfig()
    {
        return $this->config;
    }

    public function withScopeSeparator(string $scopeSeparator)
    {
        $this->scopeSeparator = $scopeSeparator;

        return $this;
    }

    public function getClientId(): ?string
    {
        return $this->config['client_id'] ?? null;
    }

    public function getClientSecret(): ?string
    {
        return $this->config['client_secret'] ?? null;
    }

    public function getHttpClient(): GuzzleClient
    {
        return $this->httpClient ?? new GuzzleClient($this->guzzleOptions);
    }

    public function setGuzzleOptions(array $config)
    {
        $this->guzzleOptions = $config;

        return $this;
    }

    public function getGuzzleOptions(): array
    {
        return $this->guzzleOptions;
    }

    protected function formatScopes(array $scopes, string $scopeSeparator): string
    {
        return \implode($scopeSeparator, $scopes);
    }

    protected function getTokenFields(string $code): array
    {
        return [
            'client_id' => $this->getClientId(),
            'client_secret' => $this->getClientSecret(),
            'code' => $code,
            'redirect_uri' => $this->redirectUrl,
        ];
    }

    protected function buildAuthUrlFromBase(string $url): string
    {
        $query = $this->getCodeFields() + ($this->state ? ['state' => $this->state] : []);

        return $url.'?'.\http_build_query($query, '', '&', $this->encodingType);
    }

    protected function getCodeFields(): array
    {
        $fields = \array_merge(
            [
                'client_id' => $this->getClientId(),
                'redirect_uri' => $this->redirectUrl,
                'scope' => $this->formatScopes($this->scopes, $this->scopeSeparator),
                'response_type' => 'code',
            ],
            $this->parameters
        );

        if ($this->state) {
            $fields['state'] = $this->state;
        }

        return $fields;
    }

    protected function normalizeAccessTokenResponse($response): array
    {
        if ($response instanceof StreamInterface) {
            $response->tell() && $response->rewind();
            $response = (string) $response;
        }

        if (\is_string($response)) {
            $response = Utils::jsonDecode($response, true);
        }

        if (! \is_array($response)) {
            throw new \Exception('Invalid token response', [$response]);
        }

        if (empty($response[$this->accessTokenKey])) {
            throw new \Exception('Authorize Failed: '.Utils::jsonEncode($response, \JSON_UNESCAPED_UNICODE), $response);
        }

        return $response + [
            'access_token' => $response[$this->accessTokenKey],
            'refresh_token' => $response[$this->refreshTokenKey] ?? null,
            'expires_in' => \intval($response[$this->expiresInKey] ?? 0),
        ];
    }

    protected function fromJsonBody(MessageInterface $response): array
    {
        $result = Utils::jsonDecode((string) $response->getBody(), true);

        if(! \is_array($result)){
            throw new \Exception('Decoded the given response payload failed.');
        }

        return $result;
    }
}
