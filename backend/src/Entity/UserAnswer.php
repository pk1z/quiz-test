<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\AnswerRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AnswerRepository::class)]
#[ApiResource]
class UserAnswer
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Answer::class, inversedBy: 'userAnswers')]
    private ?Answer $answer = null;

    public function getAnswer(): ?Answer
    {
        return $this->answer;
    }

    public function setAnswer(?Answer $answer): void
    {
        $this->answer = $answer;
    }

    #[ORM\ManyToOne(targetEntity: Question::class, inversedBy: 'userAnswers')]
    private ?Question $question = null;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'userAnswers')]
    private ?User $user = null;

    public function getQuestion(): ?Question
    {
        return $this->question;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): void
    {
        $this->user = $user;
    }

    public function setQuestion(?Question $question): void
    {
        $this->question = $question;
    }

    public function getId(): ?int
    {
        return $this->id;
    }
}
