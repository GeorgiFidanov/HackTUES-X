<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Data extends Model
{
    use HasFactory;

    public function device(){
        return $this->belongsTo(Device::class);
    }

    protected $fillable = [
        'temperature',
        'noise',
        'salinity',
        'murkiness',
        'device_id'
    ];
}
