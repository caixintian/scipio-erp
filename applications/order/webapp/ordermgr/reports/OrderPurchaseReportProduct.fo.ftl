<#--
This file is subject to the terms and conditions defined in the
files 'LICENSE' and 'NOTICE', which are part of this source
code package.
-->

<#escape x as x?xml>
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

<#-- do not display columns associated with values specified in the request, ie constraint values -->
<#assign showProductStore = !parameters.productStoreId?has_content>
<#assign showOriginFacility = !parameters.originFacilityId?has_content>
<#assign showTerminal = !parameters.terminalId?has_content>
<#assign showStatus = !parameters.statusId?has_content>

<fo:layout-master-set>
    <fo:simple-page-master master-name="main" page-height="11in" page-width="8.5in"
            margin-top="0.5in" margin-bottom="1in" margin-left="1in" margin-right="1in">
        <fo:region-body margin-top="1in"/>
        <fo:region-before extent="1in"/>
        <fo:region-after extent="1in"/>
    </fo:simple-page-master>
</fo:layout-master-set>
<#if security.hasEntityPermission("ORDERMGR", "_VIEW", request)>

<#if orderPurchaseProductSummaryList?has_content>
        <fo:page-sequence master-reference="main">
        <fo:flow flow-name="xsl-region-body" font-family="Helvetica">
            <fo:block font-size="14pt">${uiLabelMap.OrderReportPurchasesByProduct}</fo:block>
            <#if !showProductStore><fo:block font-size="10pt">${uiLabelMap.CommonFor} ${uiLabelMap.ProductProductStore}: ${parameters.productStoreId}</fo:block></#if>
            <#if !showOriginFacility><fo:block font-size="10pt">${uiLabelMap.CommonFor} ${uiLabelMap.FormFieldTitle_originFacilityId}: ${parameters.originFacilityId}</fo:block></#if>
            <#if !showTerminal><fo:block font-size="10pt">${uiLabelMap.CommonFor} ${uiLabelMap.FormFieldTitle_terminalId}: ${parameters.terminalId}</fo:block></#if>
            <#if !showStatus><fo:block font-size="10pt">${uiLabelMap.CommonFor} ${uiLabelMap.CommonStatus}: ${parameters.statusId}</fo:block></#if>
            <#if parameters.fromOrderDate?has_content><fo:block font-size="10pt">${uiLabelMap.CommonFromDate}: ${parameters.fromOrderDate} (${uiLabelMap.OrderDate} &gt;= ${uiLabelMap.CommonFrom})</fo:block></#if>
            <#if parameters.thruOrderDate?has_content><fo:block font-size="10pt">${uiLabelMap.CommonThruDate}: ${parameters.thruOrderDate} (${uiLabelMap.OrderDate} &lt; ${uiLabelMap.CommonFrom})</fo:block></#if>
            <fo:block space-after.optimum="10pt" font-size="10pt">
            <fo:table>
                <#if showProductStore><fo:table-column column-width="50pt"/></#if>
                <#if showOriginFacility><fo:table-column column-width="50pt"/></#if>
                <#if showTerminal><fo:table-column column-width="50pt"/></#if>
                <#if showStatus><fo:table-column column-width="50pt"/></#if>
                <fo:table-column column-width="80pt"/>
                <fo:table-column column-width="120pt"/>
                <fo:table-column column-width="40pt"/>
                <fo:table-column column-width="40pt"/>
                <fo:table-header>
                    <fo:table-row font-weight="bold">
                        <#if showProductStore><fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.FormFieldTitle_productStoreId}</fo:block></fo:table-cell></#if>
                        <#if showOriginFacility><fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.FormFieldTitle_facilityId}</fo:block></fo:table-cell></#if>
                        <#if showTerminal><fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.FormFieldTitle_terminalId}</fo:block></fo:table-cell></#if>
                        <#if showStatus><fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.CommonStatus}</fo:block></fo:table-cell></#if>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.FormFieldTitle_productId}</fo:block></fo:table-cell>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.ProductProductName}</fo:block></fo:table-cell>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.OrderQty}</fo:block></fo:table-cell>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block>${uiLabelMap.OrderQuantityCancelled}</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <#assign rowColor = "white">
                    <#list orderPurchaseProductSummaryList as orderPurchaseProductSummary>
                        <fo:table-row>
                            <#if showProductStore>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                    <fo:block>${orderPurchaseProductSummary.productStoreId!}</fo:block>
                                </fo:table-cell>
                            </#if>
                            <#if showOriginFacility>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                    <fo:block>${orderPurchaseProductSummary.originFacilityId!}</fo:block>
                                </fo:table-cell>
                            </#if>
                            <#if showTerminal>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                    <fo:block>${orderPurchaseProductSummary.terminalId!}</fo:block>
                                </fo:table-cell>
                            </#if>
                            <#if showStatus>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                    <fo:block>${orderPurchaseProductSummary.statusId!}</fo:block>
                                </fo:table-cell>
                            </#if>
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block>${orderPurchaseProductSummary.productId!}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block>${orderPurchaseProductSummary.internalName!}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block>${orderPurchaseProductSummary.quantity!}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block>${orderPurchaseProductSummary.cancelQuantity!}</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <#-- toggle the row color -->
                        <#if rowColor == "white">
                            <#assign rowColor = "#D4D0C8">
                        <#else>
                            <#assign rowColor = "white">
                        </#if>
                    </#list>
                </fo:table-body>
            </fo:table>
            </fo:block>
        </fo:flow>
        </fo:page-sequence>
<#else>
    <fo:page-sequence master-reference="main">
    <fo:flow flow-name="xsl-region-body" font-family="Helvetica">
        <fo:block font-size="14pt">
            ${uiLabelMap.OrderNoPurchaseProduct}
        </fo:block>
    </fo:flow>
    </fo:page-sequence>
</#if>

<#else>
    <fo:block font-size="14pt">
        ${uiLabelMap.OrderViewPermissionError}
    </fo:block>
</#if>

</fo:root>
</#escape>
