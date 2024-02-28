<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\TestResultRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: TestResultRepository::class)]
#[ApiResource]
class TestResult
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    public function getId(): ?int
    {
        return $this->id;
    }
}
