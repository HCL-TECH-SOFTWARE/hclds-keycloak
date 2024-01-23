/*
 ********************************************************************
 * Licensed Materials - Property of HCL                             *
 *                                                                  *
 * Copyright HCL Technologies Ltd. 2001, 2023. All Rights Reserved. *
 *                                                                  *
 * Note to US Government Users Restricted Rights:                   *
 *                                                                  *
 * Use, duplication or disclosure restricted by GSA ADP Schedule    *
 ********************************************************************
 */
package com.hcl.dx.auth.jaas;

import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.security.auth.spi.LoginModule;

import com.ibm.json.java.JSONObject;
import com.ibm.wps.vmm.adapter.softgroups.SoftgroupServiceException;

public interface ITransientUsersLoginModule extends LoginModule {
    
    /**
     * Resolve and return the groups associated to the provided user. 
     * 
     * @param subjectUserInfoJSON the JSONObject for the current subject to resolve groups for
     * 
     * @return {@code List<String>} of group names the current subject is assigned to.
     */
    public Map<String, List<String>> getGroupsForCurrentSubject(String uniqueid, JSONObject subjectUserInfoJSON);
    
    /**
     * Resolve and return the groups that are available to be used within DX.
     * 
     * @param groupAttributeValues the Map<String, List<String>> attribute values of groups/roles fetched from the subjectUserInfo
     * 
     * @return {@code List<String>} of group names available to be used within HCL Digital Experience.
     * @throws NamingException 
     * @throws SoftgroupServiceException 
     */
    public List<String> getAvailableGroups(Map<String, List<String>> groupAttributeValues) throws NamingException, SoftgroupServiceException;

}