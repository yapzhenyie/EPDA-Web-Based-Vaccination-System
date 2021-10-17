package model;

import java.sql.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.UserAccount;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-10-10T10:50:12")
@StaticMetamodel(MinistryStaff.class)
public class MinistryStaff_ { 

    public static volatile SingularAttribute<MinistryStaff, String> addressCountry;
    public static volatile SingularAttribute<MinistryStaff, String> nricNo;
    public static volatile SingularAttribute<MinistryStaff, Integer> gender;
    public static volatile SingularAttribute<MinistryStaff, String> addressStreet;
    public static volatile SingularAttribute<MinistryStaff, String> addressPostcode;
    public static volatile SingularAttribute<MinistryStaff, String> name;
    public static volatile SingularAttribute<MinistryStaff, Date> dateOfBirth;
    public static volatile SingularAttribute<MinistryStaff, String> addressState;
    public static volatile SingularAttribute<MinistryStaff, Integer> id;
    public static volatile SingularAttribute<MinistryStaff, UserAccount> account;
    public static volatile SingularAttribute<MinistryStaff, String> contactNo;
    public static volatile SingularAttribute<MinistryStaff, String> addressCity;

}