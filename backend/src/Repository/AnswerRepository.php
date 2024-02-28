<?php

namespace App\Repository;

use App\Entity\Answer;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Answer>
 *
 * @method Answer|null find($id, $lockMode = null, $lockVersion = null)
 * @method Answer|null findOneBy(array $criteria, array $orderBy = null)
 * @method Answer[]    findAll()
 * @method Answer[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnswerRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Answer::class);
    }

    public function findByUserAndStepRandomOrder($uuid, $step)
    {
        $answers = $this->createQueryBuilder('a')
                ->select('a.id', 'a.answerText')
                ->join('a.question', 'q')
                ->join('q.userQuestions', 'uq')
                ->join('uq.user', 'u')
                ->where('uq.stepNumber = :step')
                ->andWhere('u.uuid = :uuid')
                ->setParameter('step', $step)
                ->setParameter('uuid', $uuid)
                ->orderBy('a.id', 'ASC')
                ->setMaxResults(10)
                ->getQuery()
                ->getResult()
        ;

        shuffle($answers);

        return $answers;
    }
}
