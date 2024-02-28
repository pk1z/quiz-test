<?php

namespace App\Repository;

use App\Entity\UserTestSession;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<UserTestSession>
 *
 * @method UserTestSession|null find($id, $lockMode = null, $lockVersion = null)
 * @method UserTestSession|null findOneBy(array $criteria, array $orderBy = null)
 * @method UserTestSession[]    findAll()
 * @method UserTestSession[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserTestSessionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UserTestSession::class);
    }

    //    /**
    //     * @return UserTestSession[] Returns an array of UserTestSession objects
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

    //    public function findOneBySomeField($value): ?UserTestSession
    //    {
    //        return $this->createQueryBuilder('u')
    //            ->andWhere('u.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
