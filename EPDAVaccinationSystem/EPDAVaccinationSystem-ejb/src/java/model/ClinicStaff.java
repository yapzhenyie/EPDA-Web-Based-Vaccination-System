/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Yap Zhen Yie
 */
@Entity
@Table(name = "ClinicStaff")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ClinicStaff.findByUserAccount", query = "SELECT a FROM ClinicStaff a WHERE a.account = :account_id")
    ,@NamedQuery(name = "ClinicStaff.findAllActiveAccount", query = "SELECT a FROM ClinicStaff a WHERE a.account.accountStatus = classes.AccountStatus.Active")})
public class ClinicStaff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "nric_no")
    private String nricNo;
    @Column(name = "gender")
    private int gender;
    @Column(name = "date_of_birth")
    private Date dateOfBirth;
    @Column(name = "contact_no")
    private String contactNo;
    @Column(name = "clinic_name")
    private String clinicName;
    @Column(name = "vaccination_capacity")
    private Integer vaccinationCapacity;
    @Column(name = "address_street")
    private String addressStreet;
    @Column(name = "address_city")
    private String addressCity;
    @Column(name = "address_state")
    private String addressState;
    @Column(name = "address_postcode")
    private String addressPostcode;
    @Column(name = "address_country")
    private String addressCountry;
    @OneToOne
    @JoinColumn(name = "account_id")
    private UserAccount account;
    @OneToMany(mappedBy = "clinic")
    private List<Appointment> appointments = new ArrayList<>();
    @OneToMany(mappedBy = "clinic")
    private List<Vaccination> vaccinations = new ArrayList<>();

    public ClinicStaff() {
    }

    public ClinicStaff(String name, String nricNo, int gender, Date dateOfBirth, String contactNo, String clinicName, Integer vaccinationCapacity, String addressStreet, String addressCity, String addressState, String addressPostcode, String addressCountry, UserAccount account) {
        this.name = name;
        this.nricNo = nricNo;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.contactNo = contactNo;
        this.clinicName = clinicName;
        this.vaccinationCapacity = vaccinationCapacity;
        this.addressStreet = addressStreet;
        this.addressCity = addressCity;
        this.addressState = addressState;
        this.addressPostcode = addressPostcode;
        this.addressCountry = addressCountry;
        this.account = account;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNricNo() {
        return nricNo;
    }

    public void setNricNo(String nricNo) {
        this.nricNo = nricNo;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getClinicName() {
        return clinicName;
    }

    public void setClinicName(String clinicName) {
        this.clinicName = clinicName;
    }

    public Integer getVaccinationCapacity() {
        return vaccinationCapacity;
    }

    public void setVaccinationCapacity(Integer vaccinationCapacity) {
        this.vaccinationCapacity = vaccinationCapacity;
    }

    public String getAddressStreet() {
        return addressStreet;
    }

    public void setAddressStreet(String addressStreet) {
        this.addressStreet = addressStreet;
    }

    public String getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(String addressCity) {
        this.addressCity = addressCity;
    }

    public String getAddressState() {
        return addressState;
    }

    public void setAddressState(String addressState) {
        this.addressState = addressState;
    }

    public String getAddressPostcode() {
        return addressPostcode;
    }

    public void setAddressPostcode(String addressPostcode) {
        this.addressPostcode = addressPostcode;
    }

    public String getAddressCountry() {
        return addressCountry;
    }

    public void setAddressCountry(String addressCountry) {
        this.addressCountry = addressCountry;
    }

    public UserAccount getAccount() {
        return account;
    }

    public void setAccount(UserAccount account) {
        this.account = account;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }

    public List<Vaccination> getVaccinations() {
        return vaccinations;
    }

    public void setVaccinations(List<Vaccination> vaccinations) {
        this.vaccinations = vaccinations;
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
        if (!(object instanceof ClinicStaff)) {
            return false;
        }
        ClinicStaff other = (ClinicStaff) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.ClinicStaff[ id=" + id + ", name=" + name + " ]";
    }

}
