<?php

namespace addons\dramas\library\thirdLogin;

use addons\dramas\library\thirdLogin\src\Traits\HasAttributes;

class User
{
    use HasAttributes;

    public function __construct(array $attributes, $provider = null)
    {
        $this->attributes = $attributes;
    }

    public function getId()
    {
        return $this->getAttribute('id') ?? $this->getEmail();
    }

    public function getNickname(): ?string
    {
        return $this->getAttribute('nickname') ?? $this->getName();
    }

    public function getName(): ?string
    {
        return $this->getAttribute('name');
    }

    public function getEmail(): ?string
    {
        return $this->getAttribute('email');
    }

    public function getAvatar(): ?string
    {
        return $this->getAttribute('avatar');
    }

    public function setAccessToken(string $value): self
    {
        $this->setAttribute('access_token', $value);

        return $this;
    }

    public function getAccessToken(): ?string
    {
        return $this->getAttribute('access_token');
    }

    public function setRefreshToken(?string $value): self
    {
        $this->setAttribute('refresh_token', $value);

        return $this;
    }

    public function getRefreshToken(): ?string
    {
        return $this->getAttribute('refresh_token');
    }

    public function setExpiresIn(int $value): self
    {
        $this->setAttribute('expires_in', $value);

        return $this;
    }

    public function getExpiresIn(): ?int
    {
        return $this->getAttribute('expires_in');
    }

    public function setRaw(array $user): self
    {
        $this->setAttribute('raw', $user);

        return $this;
    }

    public function getRaw(): array
    {
        return $this->getAttribute('raw', []);
    }

    public function setTokenResponse(array $response): self
    {
        $this->setAttribute('token_response', $response);

        return $this;
    }

    public function getTokenResponse()
    {
        return $this->getAttribute('token_response');
    }

    public function jsonSerialize(): array
    {
        return $this->attributes;
    }

    public function __serialize(): array
    {
        return $this->attributes;
    }

    public function __unserialize(array $serialized): void
    {
        $this->attributes = $serialized ?: [];
    }

    public function getProvider()
    {
        if(isset($this->provider)){
            return $this->provider;
        }else{
            throw new \Exception('The provider instance doesn\'t initialized correctly.');
        }
    }

    public function setProvider($provider): self
    {
        $this->provider = $provider;

        return $this;
    }
}
