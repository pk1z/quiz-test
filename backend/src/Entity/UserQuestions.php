<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\UserQuestionsRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: UserQuestionsRepository::class)]
#[ApiResource]
class UserQuestions
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $stepNumber = null;

    public function getStepNumber(): ?int
    {
        return $this->stepNumber;
    }

    public function setStepNumber(?int $stepNumber): void
    {
        $this->stepNumber = $stepNumber;
    }

    #[ORM\Column(nullable: true)]
    private ?bool $isCorrect = null;

    #[ORM\ManyToOne(targetEntity: Question::class, inversedBy: 'userQuestions')]
    private ?Question $question = null;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'userQuestions')]
    private ?User $user = null;

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): void
    {
        $this->user = $user;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function isIsCorrect(): ?bool
    {
        return $this->isCorrect;
    }

    public function setIsCorrect(bool $isCorrect): static
    {
        $this->isCorrect = $isCorrect;

        return $this;
    }

    public function getQuestion(): ?Question
    {
        return $this->question;
    }

    public function setQuestion(?Question $question): void
    {
        $this->question = $question;
    }
}
