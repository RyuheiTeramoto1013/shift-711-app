<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シフト管理システム</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-gray-100 flex flex-col items-center justify-center min-h-screen">
    <div class="bg-white rounded shadow p-8 w-full max-w-md text-center">
        <h1 class="text-2xl font-bold mb-4">
            ようこそ！<br>
            セブンイレブンシフト管理システムへ
        </h1>
        <p class="mb-6 text-gray-700">シフトの確認・変更・申請が簡単に行えます。</p>
        <div class="flex justify-center gap-4">
            <a href="{{ url('/login') }}" class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">ログイン</a>
            <a href="{{ url('/register') }}" class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">新規登録</a>
        </div>
    </div>
</body>
</html>