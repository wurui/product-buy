define(['oxjs'], function (OXJS) {
    var getAddress = function ($div) {
            var obj = {
                toString:function(){
                    return [this.name,this.phone,this.province,this.city,this.district,this.street,this.detail ].join(' ')
                }
            };
            var addressfields = 'name,phone,province,city,district,street,detail'.split(',');
            for (var i = 0; i < addressfields.length; i++) {
                var field = addressfields[i];
                obj[field] = $('.J_address_' + field, $div).html();
            }
            return obj;
        };
    return {
        init: function ($mod) {
            /**
             * 'title',totalcount,totalfee,delivery,pack,bill
             * */
//            var Rest = OXJS.useREST('order').setDevHost('http://dev.openxsl.com/');;

            var triggerTd;

            var payurl = $mod.attr('data-payurl');

            var f = $('form', $mod)[0];

            var onAmountChange = function () {
                var amount = $amountInput.val();
                $count.html(amount);
                var total = amount * price
                $totalPrice.html(total);
                f.total.value = total;
            };

            var $count = $('.J_count', $mod),
                $totalPrice = $('.J_total', $mod),
                price = $.trim($('.J_price').text()) - 0,
                $amountInput = $('.J_input', $mod).on('change', onAmountChange);

            


            var $popup = $('.J_popup', $mod).on('click', function () {
                $popup.removeClass('popup-show')
            }).on('change', function (e) {
                //console.log('addr changed!', e.target,triggerTd);
                var $li = $(e.target).closest('li'),
                    name = $('.J_addr_name', $li).html(),
                    detail = $('.J_addr_detail', $li).html();
                $('.J_addr_name', triggerTd).html(name);
                $('.J_addr_detail', triggerTd).html(detail);
            });
            var tap_ts = 0;
            $mod.on('click', function (e) {//OXJS.toast('clicked')
                var tar = e.target,
                    action = tar.getAttribute('data-action');

                if (Date.now() - tap_ts < 100) {
                    return false
                }
                tap_ts = Date.now();
                //triggerTd=null;
                switch (action) {
                    case 'popup':
                        $popup.addClass('popup-show');
                        triggerTd = $(tar).closest('td');
                        break
                    case 'plus':
                        var $input = $(tar).prev('.J_input');
                        $input.val($input.val() - -1);
                        onAmountChange();
                        break
                    case 'minus':

                        var $input = $(tar).next('.J_input');
                        $input.val(Math.max(1, $input.val() - 1));
                        onAmountChange();
                        break
                    case 'submit':
                        var param = OXJS.formToJSON(f);

                        var postdata={
                            $order:{
                                orders:{
                                    title:param.product_title+'X'+param.amount,
                                    totalfee:param.total-0,
                                    //time:Date.now(),
                                    totalcount:param.amount-0,
                                    //seller:'',
                                   // buyer:OXJS.getUID(),
                                    delivery:getAddress(f).toString(),
                                    bill:[
                                        {item:param.product_title+'X'+param.amount,value:param.total-0}
                                    ],
                                    content:[
                                        {
                                            name:param.product_title,
                                            amount:param.amount-0,
                                            price:param.total-0,
                                            id:param.product_id
                                        }
                                    ]
                                },
                                'product-list':{}

                            }
                            
                        }
                        //debugger
                        //param.address = getAddress(f);
                        $mod.OXPost(postdata,function(r){
                            var result=r && r[0]
                            OXJS.toast(result.error?'提交失败：'+result.error:'提交成功！')
                        })


                        //param.address = addr_name.replace(/\s+/g, '') + ' ' + addr_detail.replace(/\s+/g, '');
                        //console.log('param', param);
                        //console.log('data',dataAdapter(param))
                        /**
                        Rest.post(dataAdapter(param),function(r){
                            //console.log('order submit ok',r)
                            if(r&&r.code==0){
                                location.href = payurl + (payurl.indexOf('?') > -1 ? '&' : '?') + 'oid=' + r.message
                            }else{
                                OXJS.toast(r&& r.message||'FAIL')
                            }

                        })*/
                        /*
                         OXJS.dbtool({
                         dsname: 'orders',
                         method: 'insert',
                         data: param
                         }, function (r) {
                         if (r.data && r.data.tradeno) {
                         location.href = payurl + (payurl.indexOf('?') > -1 ? '&' : '?') + 'tradeno=' + r.data.tradeno
                         } else {
                         alert(r.error)
                         }
                         });*/
                        break;
                }
            });
        }
    }
})
