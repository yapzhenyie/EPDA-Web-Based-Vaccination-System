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
public enum EnumState {

    Perlis("Perlis"),
    Penang("Penang"),
    Kedah("Kedah"),
    Perak("Perak"),
    Kelantan("Kelantan"),
    Terengganu("Terengganu"),
    Selangor("Selangor"),
    Pahang("Pahang"),
    Negeri_Sembilan("Negeri Sembilan"),
    Melaka("Melaka"),
    Johor("Johor"),
    Sabah("Sabah"),
    Sarawak("Sarawak"),
    Kuala_Lumpur("W.P. Kuala Lumpur"),
    Putrajaya("W.P. Putrajaya"),
    Labuan("W.P. Labuan");

    private String name;
    
    private EnumState(String name) {
        this.name = name;
    }
    
    public String getName() {
        return this.name;
    }
    
    @Override
    public String toString() {
        return this.name;
    }
}
