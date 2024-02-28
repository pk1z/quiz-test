<?php

namespace App\Service;

use App\Entity\User;
use App\Entity\UserAnswer;
use App\Entity\UserQuestions;
use App\Repository\AnswerRepository;
use App\Repository\QuestionRepository;
use App\Repository\UserQuestionsRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Uid\Uuid;

class TestService
{
    private $questionRepository;
    private $userRepository;
    private $userQuestionRepository;
    private $answerRepository;
    private $manager;

    public function __construct(QuestionRepository $questionRepository,
        UserRepository $userRepository,
        UserQuestionsRepository $userQuestionRepository,
        AnswerRepository $answerRepository,
        EntityManagerInterface $manager)
    {
        $this->questionRepository = $questionRepository;
        $this->userRepository = $userRepository;
        $this->userQuestionRepository = $userQuestionRepository;
        $this->answerRepository = $answerRepository;
        $this->manager = $manager;
    }

    public function initializeTest(): string
    {
        $questions = $this->questionRepository->findAll();
        shuffle($questions);

        $uuid = Uuid::v1();
        $user = new User();
        $user->setUuid($uuid);

        $this->manager->persist($user);

        $step = 0;
        foreach ($questions as $question) {
            $userQuestion = new UserQuestions();
            $userQuestion->setQuestion($question);
            $userQuestion->setStepNumber($step);
            $userQuestion->setUser($user);
            ++$step;

            $this->manager->persist($userQuestion);
        }

        $this->manager->flush();

        return $user->getUuid();
    }

    public function getAnswersForStep(string $uuid, int $step): array
    {
        $answers = $this->answerRepository->findByUserAndStepRandomOrder(
            $uuid,
            $step,
        );

        if (!$answers) {
            throw new NotFoundHttpException('Answers not found');
        }

        return $answers;
    }

    public function getQuestionForStep(string $uuid, int $step): ?string
    {
        $user = $this->userRepository->findOneBy([
            'uuid' => $uuid,
        ]);

        if (!$user) {
            throw new NotFoundHttpException('User not found');
        }

        $userQuestion = $this->userQuestionRepository->findOneBy(
            [
                'user' => $user,
                'stepNumber' => $step,
            ]
        );

        if (!$userQuestion) {
            throw new NotFoundHttpException('Users question not found');
        }

        return $userQuestion->getQuestion()->getQuestionText();
    }

    public function submitAnswers(string $uuid, int $step, array $answerIds): bool
    {
        $user = $this->userRepository->findOneBy([
            'uuid' => $uuid,
        ]);

        if (!$user) {
            throw new NotFoundHttpException('User not found');
        }

        $afterAllResult = true;

        foreach ($answerIds as $answerId) {
            $answer = $this->answerRepository->findOneBy([
                'id' => $answerId,
            ]);

            if (!$answer) {
                throw new NotFoundHttpException('answer not found');
            }

            if (false === $answer->isCorrect()) {
                $afterAllResult = false;
            }

            $question = $this->questionRepository->findOneByStepAndUser($user, $step);

            $userAnswer = new UserAnswer();
            $userAnswer->setUser($user);
            $userAnswer->setQuestion($question);
            $userAnswer->setAnswer($answer);

            $this->manager->persist($userAnswer);
        }

        $userQuestion = $this->userQuestionRepository->findOneBy(
            [
                'user' => $user,
                'stepNumber' => $step,
            ]
        );

        $userQuestion->setIsCorrect($afterAllResult);
        $this->manager->persist($userQuestion);

        $this->manager->flush();

        return $afterAllResult;
    }

    public function getTestResults(string $uuid): array
    {
        return [
            'correct_answers' => $this->userQuestionRepository->findAnswersByUser($uuid, true),
            'incorrect_answers' => $this->userQuestionRepository->findAnswersByUser($uuid, false),
        ];
    }
}
