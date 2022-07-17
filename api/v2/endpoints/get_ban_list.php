<?php

$ban = $db->get(T_BANNED_IPS);
$response_data = array(
                    'api_status' => 200,
                    'data' => $ban
                );