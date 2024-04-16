<?php

namespace addons\dramas\library\thirdLogin;

use addons\dramas\library\thirdLogin\src\Facebook;
use addons\dramas\library\thirdLogin\src\Google;

class ThirdLogin
{
    protected $config;

    protected const PROVIDERS = [
        Google::NAME => Google::class,
        Facebook::NAME => Facebook::class,
    ];

    public function __construct(array $config)
    {
        $this->config = $config;
    }

    public function create(string $name)
    {
        $name = \strtolower($name);

        return $this->createProvider($name);
    }

    public function buildProvider(string $provider, array $config)
    {
        $instance = new $provider($config);

        return $instance;
    }

    protected function createProvider(string $name)
    {
        $config = $this->config;

        return $this->buildProvider(self::PROVIDERS[$name] ?? $name, $config);
    }

}
