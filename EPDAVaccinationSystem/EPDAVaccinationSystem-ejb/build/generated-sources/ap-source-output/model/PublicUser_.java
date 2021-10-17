package model;

import java.sql.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.UserAccount;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-10-10T10:50:12")
@StaticMetamodel(PublicUser.class)
public class PublicUser_ { 

    public static volatile SingularAttribute<PublicUser, String> addressCountry;
    public static volatile SingularAttribute<PublicUser, String> nricNo;
    public static volatile SingularAttribute<PublicUser, Integer> gender;
    public static volatile SingularAttribute<PublicUser, String> addressStreet;
    public static volatile SingularAttribute<PublicUser, String> addressPostcode;
    public static volatile SingularAttribute<PublicUser, String> name;
    public static volatile SingularAttribute<PublicUser, Date> dateOfBirth;
    public static volatile SingularAttribute<PublicUser, String> addressState;
    public static volatile SingularAttribute<PublicUser, Integer> id;
    public static volatile SingularAttribute<PublicUser, UserAccount> account;
    public static volatile SingularAttribute<PublicUser, String> contactNo;
    public static volatile SingularAttribute<PublicUser, String> addressCity;

}