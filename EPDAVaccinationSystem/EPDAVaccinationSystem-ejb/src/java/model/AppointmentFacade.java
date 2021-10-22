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
public class AppointmentFacade extends AbstractFacade<Appointment> {

    @PersistenceContext(unitName = "EPDAVaccinationSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AppointmentFacade() {
        super(Appointment.class);
    }

    public Appointment getAppointmentByDose(PublicUser vaccinator, Integer doseNo) {
        try {
            Query query = em.createNamedQuery("Appointment.getAppointmentByDose");
            query.setParameter("vaccinator_id", vaccinator);
            query.setParameter("doseNo", doseNo);
            query.setMaxResults(1);
            return (Appointment) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

}
