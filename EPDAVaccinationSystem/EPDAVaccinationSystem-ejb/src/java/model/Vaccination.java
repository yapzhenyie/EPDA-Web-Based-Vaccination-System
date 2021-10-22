/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Yap Zhen Yie
 */
@Entity
@Table(name = "Vaccination")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Vaccination.filterByDoseAndVaccinator", query = "SELECT a FROM Vaccination a WHERE a.vaccinator = :vaccinator_id AND a.dose = :doseNo ORDER BY a.completeVaccinationDate Desc, a.completeVaccinationTime Desc")
    ,@NamedQuery(name = "Vaccination.filterByDoseAndDateAsc", query = "SELECT a FROM Vaccination a WHERE a.dose = :doseNo ORDER BY a.completeVaccinationDate ASC, a.completeVaccinationTime ASC")
    ,@NamedQuery(name = "Vaccination.findAllActiveAccount", query = "SELECT a FROM Vaccination a WHERE a.vaccinator.account.accountStatus = classes.AccountStatus.Active")})
public class Vaccination implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "appointment_date")
    private Date appointmentDate;
    @Column(name = "complete_vaccination_date")
    private Date completeVaccinationDate;
    @Column(name = "complete_vaccination_time")
    private Time completeVaccinationTime;
    @Column(name = "dose")
    private Integer dose;
    @OneToOne
    @JoinColumn(name = "clinic_id")
    @ManyToOne
    private ClinicStaff clinic;
    @JoinColumn(name = "user_id")
    @ManyToOne
    private PublicUser vaccinator;

    public Vaccination() {
    }

    public Vaccination(Date appointmentDate, Date completeVaccinationDate, Time completeVaccinationTime, Integer dose, ClinicStaff clinic, PublicUser vaccinator) {
        this.appointmentDate = appointmentDate;
        this.completeVaccinationDate = completeVaccinationDate;
        this.completeVaccinationTime = completeVaccinationTime;
        this.dose = dose;
        this.clinic = clinic;
        this.vaccinator = vaccinator;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public Date getCompleteVaccinationDate() {
        return completeVaccinationDate;
    }

    public void setCompleteVaccinationDate(Date completeVaccinationDate) {
        this.completeVaccinationDate = completeVaccinationDate;
    }

    public Time getCompleteVaccinationTime() {
        return completeVaccinationTime;
    }

    public void setCompleteVaccinationTime(Time completeVaccinationTime) {
        this.completeVaccinationTime = completeVaccinationTime;
    }

    public Integer getDose() {
        return dose;
    }

    public void setDose(Integer dose) {
        this.dose = dose;
    }

    public ClinicStaff getClinic() {
        return clinic;
    }

    public void setClinic(ClinicStaff clinic) {
        this.clinic = clinic;
    }

    public PublicUser getVaccinator() {
        return vaccinator;
    }

    public void setVaccinator(PublicUser vaccinator) {
        this.vaccinator = vaccinator;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Vaccination)) {
            return false;
        }
        Vaccination other = (Vaccination) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Vaccination[ id=" + id + " ]";
    }

}
