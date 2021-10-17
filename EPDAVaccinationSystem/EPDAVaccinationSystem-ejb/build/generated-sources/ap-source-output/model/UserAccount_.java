package model;

import classes.AccountStatus;
import classes.UserRole;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-10-10T10:50:12")
@StaticMetamodel(UserAccount.class)
public class UserAccount_ { 

    public static volatile SingularAttribute<UserAccount, AccountStatus> accountStatus;
    public static volatile SingularAttribute<UserAccount, String> password;
    public static volatile SingularAttribute<UserAccount, UserRole> role;
    public static volatile SingularAttribute<UserAccount, String> id;

}