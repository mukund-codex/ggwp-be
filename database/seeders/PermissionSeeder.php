<?php

namespace Database\Seeders;

use Config;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class PermissionSeeder extends Seeder
{
    public function run(): void
    {
        Role::updateOrCreate(['name' => Config::get('const.roles.super_admin')]);
        Role::updateOrCreate(['name' => Config::get('const.roles.user')]);

        $permissions = [
            'view user',
            'create user',
            'update user',
            'view users',
            'delete user'
        ];

        foreach ($permissions as $permission) {
            Permission::updateOrCreate(['name' => $permission]);
        }
    }

}
