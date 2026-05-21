<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <!-- Scripts -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="font-sans text-gray-900 antialiased">
        <div class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-50">

            <!-- Logo -->
            <div class="mb-2">
                <a href="/">
                    <x-application-logo class="h-32 w-auto" />
                </a>
            </div>

            <!-- Card -->
            <div class="w-full sm:max-w-md mt-4 px-12 py-12 bg-white shadow-lg overflow-hidden sm:rounded-[2.5rem] border border-gray-200">

                <h2 class="text-lg font-semibold text-gray-700 mb-6 text-center">Acesse sua conta</h2>

                {{ $slot }}
            </div>

            <p class="mt-6 text-xs text-gray-400">&copy; {{ date('Y') }} MC Franqueadora</p>
        </div>
    </body>
</html>
