<?php
return [
    'app.offline' => env('OFFLINE', false),
    'app.offlineUrl' => '/em-manutencao/index.php',
    'app.offlineBypassFunction' => function() {
        $online_key = env('OFFLINE_BYPASS_KEY', 'online');
        $online_pass = env('OFFLINE_BYPASS_PASS', '');

        $senha = $_GET[$online_key] ?? '';
        
        if ($senha && $senha === $online_pass) {
            $_SESSION[$online_key] = true;
        }

        return $_SESSION[$online_key] ?? false;
    }
];