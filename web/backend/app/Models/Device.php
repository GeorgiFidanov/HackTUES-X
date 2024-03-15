<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Device extends Model
{
    use HasFactory;

    public function data(){
        return $this->hasMany(Data::class);
    }

    protected $fillable = [
        'name',
        'location',
        'company_name'
    ];
}
