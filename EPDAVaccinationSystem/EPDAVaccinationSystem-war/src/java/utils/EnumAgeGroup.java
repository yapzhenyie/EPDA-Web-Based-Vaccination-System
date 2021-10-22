/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author Yap Zhen Yie
 */
public enum EnumAgeGroup {

    Age12_17("12 to 17", 12, 17),
    Age18_24("18 to 24", 18, 24),
    Age25_34("25 to 34", 25, 34),
    Age35_54("35 to 54", 35, 54),
    Age55_Above("55+", 55, null);

    private String name;
    private Integer lowerbound;
    private Integer upperbound;
    
    private EnumAgeGroup(String name, Integer lowerbound, Integer upperbound) {
        this.name = name;
        this.lowerbound = lowerbound;
        this.upperbound = upperbound;
    }
    
    public String getName() {
        return this.name;
    }

    public Integer getLowerbound() {
        return lowerbound;
    }

    public Integer getUpperbound() {
        return upperbound;
    }
    
    @Override
    public String toString() {
        return this.name;
    }
}
