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
public class VaccinationFacade extends AbstractFacade<Vaccination> {

    @PersistenceContext(unitName = "EPDAVaccinationSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public VaccinationFacade() {
        super(Vaccination.class);
    }

    public Vaccination filterByDoseAndVaccinator(PublicUser vaccinator, Integer doseNo) {
        try {
            Query query = em.createNamedQuery("Vaccination.filterByDoseAndVaccinator");
            query.setParameter("vaccinator_id", vaccinator);
            query.setParameter("doseNo", doseNo);
            query.setMaxResults(1);
            return (Vaccination) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Vaccination> filterByDoseAndDateAsc(Integer doseNo) {
        try {
            Query query = em.createNamedQuery("Vaccination.filterByDoseAndDateAsc");
            query.setParameter("doseNo", doseNo);
            return query.getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Vaccination> findByActiveAccount() {
        try {
            Query query = em.createNamedQuery("Vaccination.findAllActiveAccount");
            return query.getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }
}
