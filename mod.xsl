<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oxm="https://www.openxsl.com">
    <xsl:template match="/root" name="wurui.product-buy">
    	<xsl:param name="buildurl"/>
        <xsl:param name="payurl"/>
        <!-- className 'J_OXMod' required  -->
        <div class="J_OXMod oxmod-product-buy" ox-mod="product-buy">
            <xsl:variable select="data/product-list/i" name="products"/>
            <xsl:variable select="data/product-list/i[1]" name="product"/>
            <xsl:variable select="data/customize/i" name="customize"/>
            <xsl:variable select="data/addressbook/i" name="addressbook" />
            <xsl:variable name="selected_addr_id" select="data/user-select/i[type='addressbook']/selected"/>
        
        
            <div class="product">
                <span class="mainpic" style="background-image:url({$product/img});"></span>
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
                            <td>
                                
                                <xsl:variable name="defAddr" select="data/addressbook/i[_id=$selected_addr_id]"/>
                                <p class="J_addr_name">
                                    <span class="J_address_name"><xsl:value-of select="normalize-space($defAddr/name)"/></span>
                                    (<span class="J_address_phone"><xsl:value-of select="normalize-space($defAddr/phone)"/></span>)
                                </p>
                                <span class="J_addr_detail">
                                    <span class="J_address_province"><xsl:value-of select="normalize-space($defAddr/province)"/></span>省
                                    <span class="J_address_city"><xsl:value-of select="normalize-space($defAddr/city)"/></span>市
                                    <span class="J_address_district"><xsl:value-of select="normalize-space($defAddr/district)"/></span>区
                                    <span class="J_address_street"><xsl:value-of select="normalize-space($defAddr/street)"/></span>街道
                                    <span class="J_address_detail"><xsl:value-of select="normalize-space($defAddr/detail)"/></span>
                                </span>
                                <button type="button" data-action="popup">&gt;</button>
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

            <div class="popup J_popup">
                <div class="cnt">
                    <ul class="addresslist">
                        <xsl:variable name="uniq_id" select="generate-id(data/addressbook)"/>
                        <xsl:for-each select="data/addressbook/i">
                            <li>
                                <xsl:variable name="radio-id" select="generate-id(.)"/>
                                <span class="sign">
                                    <input type="radio" name="{$uniq_id}" id="{$radio-id}">
                                        <xsl:if test="_id = $selected_addr_id">
                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                        </xsl:if>
                                    </input>
                                </span>
                                <label for="{$radio-id}" class="J_addr_name">
                                    <span class="J_address_name"><xsl:value-of select="normalize-space(name)"/></span>(<span class="J_address_phone"><xsl:value-of select="normalize-space(phone)"/></span>)
                                </label>
                                <br/>
                                <label for="{$radio-id}" class="J_addr_detail">
                                    <span class="J_address_province"><xsl:value-of select="normalize-space(province)"/></span>省
                                    <span class="J_address_city"><xsl:value-of select="normalize-space(city)"/></span>市
                                    <span class="J_address_district"><xsl:value-of select="normalize-space(district)"/></span>区
                                    <span class="J_address_street"><xsl:value-of select="normalize-space(street)"/></span>街道
                                    <span class="J_address_detail"><xsl:value-of select="normalize-space(detail)"/></span>
                                </label>
                            </li>
                        </xsl:for-each>
                    </ul>
                    <button class="bt-submit" type="button">确定</button>
                </div>

            </div>
            </div>
    </xsl:template>
</xsl:stylesheet>
