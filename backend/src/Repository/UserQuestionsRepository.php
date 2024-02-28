<?php

namespace App\Repository;

use App\Entity\User;
use App\Entity\UserQuestions;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<UserQuestions>
 *
 * @method UserQuestions|null find($id, $lockMode = null, $lockVersion = null)
 * @method UserQuestions|null findOneBy(array $criteria, array $orderBy = null)
 * @method UserQuestions[]    findAll()
 * @method UserQuestions[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserQuestionsRepository extends ServiceEntityRepository
{
    public function findAnswersByUser($uuid, $isCorrect)
    {
        return $this->createQueryBuilder('uq')
            ->select('q.questionText')
            ->join('uq.user', 'u')
            ->join('uq.question', 'q')
            ->where('u.uuid = :uuid')
            ->andWhere('uq.isCorrect = :isCorrect')
            ->setParameter('uuid', $uuid)
            ->setParameter('isCorrect', $isCorrect)
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }

    public function findOneByStepAndUser($user, $step)
    {
        return $this->createQueryBuilder('q')
            ->join('q.userQuestions', 'uq')
            ->where('uq.stepNumber = :step')
            ->andWhere('uq.user = :user')
            ->setParameter('step', $step)
            ->setParameter('user', $user)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }

    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UserQuestions::class);
    }

    //    /**
    //     * @return User[] Returns an array of User objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('u')
    //            ->andWhere('u.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('u.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?User
    //    {
    //        return $this->createQueryBuilder('u')
    //            ->andWhere('u.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
