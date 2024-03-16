<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Symfony\Component\Process\Exception\ProcessFailedException;
use Symfony\Component\Process\Process;

class GetAIResponses extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'get:responses';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Get responses from ai';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $process = new Process(['py', './resources/AI/AI_part.py']);
        $process->run();

        // executes after the command finishes
        if (!$process->isSuccessful()) {
            throw new ProcessFailedException($process);
        }

        echo $process->getOutput();

    }
}
