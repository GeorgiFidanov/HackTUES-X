<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AIResponse extends Model
{
    use HasFactory;

    public function device(){
        return $this->belongsTo(Device::class);
    }

    protected $fillable = [
        'type',
        'content',
        'device_id'
    ];
}
