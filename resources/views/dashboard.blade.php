<x-app-layout>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-16 pb-10">

        <div class="mb-8">
            <h1 class="text-2xl font-bold text-gray-800">
                Portal BI - MC Franqueadora
            </h1>
            <p class="mt-1 text-sm text-gray-500">
                Bem-vindo, <span class="font-semibold text-gray-700">{{ auth()->user()->name }}</span>
            </p>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
            <a href="{{ route('bi.dashboard') }}"
               class="inline-flex items-center gap-2 px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold rounded-lg shadow transition">
                Acessar Dashboard
            </a>
        </div>

    </div>
</x-app-layout>
