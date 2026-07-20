<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        // Confia no proxy do Render (e de qualquer plataforma cloud similar),
        // que termina o HTTPS na borda e repassa a requisição como HTTP puro
        // por dentro. Sem isso, o Laravel gera URLs de asset (CSS/JS) como
        // http:// mesmo em produção HTTPS, e o navegador bloqueia por
        // "mixed content".
        $middleware->trustProxies(at: '*');
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();