/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.sql.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
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
@Table(name = "MinistryStaff")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MinistryStaff.findByUserAccount", query = "SELECT a FROM MinistryStaff a WHERE a.account = :account_id")
    //, @NamedQuery(name = "MinistryStaff.findAll", query = "SELECT a,b FROM MinistryStaff a INNER JOIN a.account b")
})
public class MinistryStaff implements Serializable {

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

    public MinistryStaff() {
    }

    public MinistryStaff(String name, String nricNo, int gender, Date dateOfBirth, String contactNo, String addressStreet, String addressCity, String addressState, String addressPostcode, String addressCountry, UserAccount account) {
        this.name = name;
        this.nricNo = nricNo;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.contactNo = contactNo;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MinistryStaff)) {
            return false;
        }
        MinistryStaff other = (MinistryStaff) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.MinistryStaff[ id=" + id + " ]";
    }

}
