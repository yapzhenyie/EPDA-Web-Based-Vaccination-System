package model;

import java.sql.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.UserAccount;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-10-10T10:50:12")
@StaticMetamodel(ClinicStaff.class)
public class ClinicStaff_ { 

    public static volatile SingularAttribute<ClinicStaff, String> clinicName;
    public static volatile SingularAttribute<ClinicStaff, String> addressCountry;
    public static volatile SingularAttribute<ClinicStaff, Integer> gender;
    public static volatile SingularAttribute<ClinicStaff, String> addressPostcode;
    public static volatile SingularAttribute<ClinicStaff, Date> dateOfBirth;
    public static volatile SingularAttribute<ClinicStaff, String> addressState;
    public static volatile SingularAttribute<ClinicStaff, String> nricNo;
    public static volatile SingularAttribute<ClinicStaff, String> addressStreet;
    public static volatile SingularAttribute<ClinicStaff, String> name;
    public static volatile SingularAttribute<ClinicStaff, Integer> id;
    public static volatile SingularAttribute<ClinicStaff, UserAccount> account;
    public static volatile SingularAttribute<ClinicStaff, String> contactNo;
    public static volatile SingularAttribute<ClinicStaff, String> addressCity;

}