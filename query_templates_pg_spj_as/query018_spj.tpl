--
-- Legal Notice
--
-- This document and associated source code (the "Work") is a part of a
-- benchmark specification maintained by the TPC.
--
-- The TPC reserves all right, title, and interest to the Work as provided
-- under U.S. and international laws, including without limitation all patent
-- and trademark rights therein.
--
-- No Warranty
--
-- 1.1 TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE INFORMATION
--     CONTAINED HEREIN IS PROVIDED "AS IS" AND WITH ALL FAULTS, AND THE
--     AUTHORS AND DEVELOPERS OF THE WORK HEREBY DISCLAIM ALL OTHER
--     WARRANTIES AND CONDITIONS, EITHER EXPRESS, IMPLIED OR STATUTORY,
--     INCLUDING, BUT NOT LIMITED TO, ANY (IF ANY) IMPLIED WARRANTIES,
--     DUTIES OR CONDITIONS OF MERCHANTABILITY, OF FITNESS FOR A PARTICULAR
--     PURPOSE, OF ACCURACY OR COMPLETENESS OF RESPONSES, OF RESULTS, OF
--     WORKMANLIKE EFFORT, OF LACK OF VIRUSES, AND OF LACK OF NEGLIGENCE.
--     ALSO, THERE IS NO WARRANTY OR CONDITION OF TITLE, QUIET ENJOYMENT,
--     QUIET POSSESSION, CORRESPONDENCE TO DESCRIPTION OR NON-INFRINGEMENT
--     WITH REGARD TO THE WORK.
-- 1.2 IN NO EVENT WILL ANY AUTHOR OR DEVELOPER OF THE WORK BE LIABLE TO
--     ANY OTHER PARTY FOR ANY DAMAGES, INCLUDING BUT NOT LIMITED TO THE
--     COST OF PROCURING SUBSTITUTE GOODS OR SERVICES, LOST PROFITS, LOSS
--     OF USE, LOSS OF DATA, OR ANY INCIDENTAL, CONSEQUENTIAL, DIRECT,
--     INDIRECT, OR SPECIAL DAMAGES WHETHER UNDER CONTRACT, TORT, WARRANTY,
--     OR OTHERWISE, ARISING IN ANY WAY OUT OF THIS OR ANY OTHER AGREEMENT
--     RELATING TO THE WORK, WHETHER OR NOT SUCH AUTHOR OR DEVELOPER HAD
--     ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.
--
-- Contributors:
--
 define YEAR = random(1998, 2002, uniform);
 define GEN= dist(gender, 1, 1);
 define ES= dist(education, 1, 1);
 define STATE=sulist(dist(fips_county,3,1),3);
 define MONTH=random(1,12,uniform);
 define WHOLESALE_COST = range(random (0, 100, uniform), 5);
 define CATEGORY = dist(categories,1,1);

 select min(i_item_id) as min_i_item_id,
        min(ca_country) as min_ca_country,
        min(ca_state) as min_ca_state,
        min(ca_county) as min_ca_county,
        min(cs_quantity) as min_cs_quantity,
        min(cs_list_price) as min_cs_list_price,
        min(cs_coupon_amt) as min_cs_coupon_amt,
        min(cs_sales_price) as min_cs_sales_price,
        min(cs_net_profit) as min_cs_net_profit,
        min(c_birth_year) as min_c_birth_year,
        min(cd_dep_count) as min_cd_dep_count
 from catalog_sales, customer_demographics, customer, customer_address, date_dim, item
 where cs_sold_date_sk = d_date_sk and
       cs_item_sk = i_item_sk and
       cs_bill_cdemo_sk = cd_demo_sk and
       cs_bill_customer_sk = c_customer_sk and
       cd_gender = '[GEN]' and
       cd_education_status = '[ES]' and
       c_current_addr_sk = ca_address_sk and
       d_year = [YEAR] and
       c_birth_month = [MONTH] and
       ca_state in ('[STATE.1]', '[STATE.2]', '[STATE.3]')
       and cs_wholesale_cost BETWEEN [WHOLESALE_COST.begin] AND [WHOLESALE_COST.end]
       AND i_category = '[CATEGORY]'
;
