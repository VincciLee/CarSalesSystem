package model;

import java.time.LocalDate;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-22T15:43:12")
@StaticMetamodel(Sales.class)
public class Sales_ { 

    public static volatile SingularAttribute<Sales, Integer> salesman_id;
    public static volatile SingularAttribute<Sales, Integer> customer_rating;
    public static volatile SingularAttribute<Sales, String> salesman_comment;
    public static volatile SingularAttribute<Sales, LocalDate> booked_date;
    public static volatile SingularAttribute<Sales, LocalDate> accepted_date;
    public static volatile SingularAttribute<Sales, Integer> id;
    public static volatile SingularAttribute<Sales, Integer> customer_id;
    public static volatile SingularAttribute<Sales, Integer> car_id;
    public static volatile SingularAttribute<Sales, LocalDate> canceled_date;
    public static volatile SingularAttribute<Sales, String> customer_feedback;
    public static volatile SingularAttribute<Sales, LocalDate> completed_date;
    public static volatile SingularAttribute<Sales, String> status;

}