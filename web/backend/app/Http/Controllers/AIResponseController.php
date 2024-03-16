<?php

namespace App\Http\Controllers;

use App\Models\AIResponse;
use App\Models\Device;
use Illuminate\Http\Request;

class AIResponseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Device::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        AIResponse::create($request->all());
        return response()->json();
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        return AIResponse::where('device_id', '=', $id)->get();
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, AIResponse $aIResponse)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(AIResponse $aIResponse)
    {
        //
    }
}
