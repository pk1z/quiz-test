<?php

// src/Controller/Api/MainController.php

namespace App\Controller\Api;

use App\Service\TestService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api')]
class MainController extends AbstractController
{
    private TestService $testService;

    public function __construct(TestService $testService)
    {
        $this->testService = $testService;
    }

    #[Route('/start', name: 'api_test_start', methods: ['POST'])]
    public function startTest(): JsonResponse
    {
        $uuid = $this->testService->initializeTest();

        return $this->json(['uuid' => $uuid]);
    }

    #[Route('/question/{uuid}/{step}', name: 'api_test_question', methods: ['GET'])]
    public function getQuestion(string $uuid, int $step): JsonResponse
    {
        $question = $this->testService->getQuestionForStep($uuid, $step);

        $answers = $this->testService->getAnswersForStep($uuid, $step);

        return $this->json([
            'question' => $question,
            'answers' => $answers,
        ]);
    }

    #[Route('/submit/{uuid}/{step}', name: 'api_test_submit', methods: ['POST'])]
    public function submitAnswer(Request $request, string $uuid, int $step): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $isCorrect = $this->testService->submitAnswers($uuid, $step, $data['answers']);

        return $this->json(['isCorrect' => $isCorrect]);
    }

    #[Route('/results/{uuid}', name: 'api_test_results', methods: ['GET'])]
    public function getResults(string $uuid): JsonResponse
    {
        $results = $this->testService->getTestResults($uuid);

        return $this->json($results);
    }
}
