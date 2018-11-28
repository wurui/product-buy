<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oxm="https://www.openxsl.com">
    <xsl:template match="/root" name="wurui.product-buy">
    	
        <!-- className 'J_OXMod' required  -->
        <div class="J_OXMod oxmod-product-buy" ox-mod="product-buy" data-ts="{/root/attribute::ts_r}">
            <xsl:variable select="data/ecom-products/i" name="products"/>
            <xsl:variable select="data/ecom-products/i[1]" name="product"/>
            
            <xsl:variable select="data/user-address/i" name="addressbook" />

            <xsl:variable name="selected_addr_id" select="data/user-select/i[type='user-address']/selected"/>
        
        
            <div class="product">
                <span class="mainpic" style="background-image:url({$product/media/i[type='image'][1]/src});"></span>
                <h3 class="title">
                    <xsl:value-of select="$product/title"/>
                </h3>
                <p>
                    <span class="price J_price">
                        <xsl:value-of select="$product/price"/>
                    </span>
                </p>
            </div>
            <form>
                <input type="hidden" value="{$product/_id}" name="product_id"/>
                <input type="hidden" value="{$product/title}" name="product_title"/>
                <input type="hidden" value="{$product/price}" name="product_price"/>
                
                <table class="ordertable" cellpadding="0" cellspacing="0">
                    <tbody>
                        <tr>
                            <th>购买数量</th>
                            <td>
                                <span class="num-ctrl">
                                    <button type="button" data-action="minus">-</button>
                                    <input type="number" name="amount" min="1" class="J_input" size="2" value="1"/>
                                    <button type="button" data-action="plus">+</button>
                                </span>
                            </td>
                        </tr>
                 
                        <tr>
                            <th>
                                <nobr>收货地址</nobr>
                            </th>
                            <td ox-refresh="html">
                                
                                <xsl:variable name="defAddr" select="data/user-address/i[_id=$selected_addr_id]"/>
                                <p class="J_addr_name">
                                    <span class="J_address_name"><xsl:value-of select="normalize-space($defAddr/name)"/></span>
                                    &#160;<span class="J_address_phone"><xsl:value-of select="normalize-space($defAddr/phone)"/></span>
                                </p>
                                <span class="J_addr_detail">
                                    <span class="J_address_province"><xsl:value-of select="normalize-space($defAddr/province)"/></span>
                                    <span class="J_address_city"><xsl:value-of select="normalize-space($defAddr/city)"/></span>
                                    <span class="J_address_district"><xsl:value-of select="normalize-space($defAddr/district)"/></span>
                                    <!--
                                    <span class="J_address_street"><xsl:value-of select="normalize-space($defAddr/street)"/></span>街道-->
                                    <span class="J_address_detail"><xsl:value-of select="normalize-space($defAddr/detail)"/></span>
                                </span>
                                
                                <a href="{$defAddr/LINK/addresslist}"><nobr>&#160;&#160;&#160;&#160;地址管理&gt;</nobr></a>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="total">
                    合计:&#160;&#160;
                    <span class="price J_total">
                        <xsl:value-of select="$product/price"/>
                    </span>
                    <input type="hidden" name="total" value="{$product/price}"/>
                </p>
           
                <div class="op">
                    <button class="bt-submit" data-action="submit" type="button">提交订单</button>
                </div>

            </form>

   
        </div>
    </xsl:template>
</xsl:stylesheet>
