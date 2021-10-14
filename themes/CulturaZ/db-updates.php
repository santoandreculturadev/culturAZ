<?php

use function MapasCulturais\__exec;

$app = MapasCulturais\App::i();
$em = $app->em;
$conn = $em->getConnection();

return [
    'fix-registrations' => function() {
        __exec("UPDATE registration SET number = concat('on-', id), consolidated_result = status");
    }
];