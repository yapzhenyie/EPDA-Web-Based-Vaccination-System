/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

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
public class ClinicStaffFacade extends AbstractFacade<ClinicStaff> {

    @PersistenceContext(unitName = "EPDAVaccinationSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ClinicStaffFacade() {
        super(ClinicStaff.class);
    }

    public ClinicStaff findByUserAccount(UserAccount accountId) {
        try {
            Query query = em.createNamedQuery("ClinicStaff.findByUserAccount").setParameter("account_id", accountId);
            return (ClinicStaff) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
