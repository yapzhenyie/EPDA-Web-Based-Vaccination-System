/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Yap Zhen Yie
 */
@Stateless
public class PublicUserFacade extends AbstractFacade<PublicUser> {

    @PersistenceContext(unitName = "EPDAVaccinationSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PublicUserFacade() {
        super(PublicUser.class);
    }

    public PublicUser findByUserAccount(UserAccount accountId) {
        try {
            Query query = em.createNamedQuery("PublicUser.findByUserAccount").setParameter("account_id", accountId);
            return (PublicUser) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }


    public List<PublicUser> findByActiveAccount() {
        try {
            Query query = em.createNamedQuery("PublicUser.findAllActiveAccount");
            return query.getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

}
