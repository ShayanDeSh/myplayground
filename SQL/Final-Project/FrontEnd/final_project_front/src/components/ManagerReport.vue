<template>
    <div>
        <div class="container">
            <div style="width: 75%; margin: auto">
                <div style="padding-left: 50px">
                    <div style="display: block; margin: auto; padding-top: 10px">
                        <input v-model="date.year" style="display: inline; width: 5rem" placeholder="year"
                               type="number">
                        <input v-model="date.month" style="display: inline; width: 5rem" placeholder="month"
                               type="number">
                        <input v-model="date.day" style="display: inline; width: 5rem" placeholder="day" type="number">
                    </div>
                    <input @click="getData" type="button" value="Get Data">
                </div>
            </div>
        </div>
        <div v-if="report != null" style="margin-top: 10px" class="container">
            <div style="width: 75%; margin: auto">
                <div style="padding-left: 50px">
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>Total Buy</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input disabled :value="report.total_buy" type="text"/>
                        </div>
                    </div>
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>Total Sale</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input disabled :value="report.total_sell" type="text"/>
                        </div>
                    </div>
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>Profit</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input disabled :value="report.profit" type="text"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="report != null">
            <div v-for="(sale, index) in report.sale_factors" :key="index"
                 style="margin-top: 10px; padding-bottom: 15px"
                 class="container">
                <div style="width: 75%; margin: auto">
                    <div style="padding-left: 50px">
                        <h1 style="color: #58d78c; margin-right: 20px">Sale Factor</h1>
                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Factor Id</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="sale.factor_id" type="number"/>
                            </div>
                        </div>
                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Total price</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="sale.total_price" type="text"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="report != null">
            <div v-for="(buy, index) in report.buy_factors" :key="index"
                 style="margin-top: 10px; padding-bottom: 15px"
                 class="container">
                <div style="width: 75%; margin: auto">
                    <div style="padding-left: 50px">
                        <h1 style="color: #58d78c; margin-right: 20px">Buy Factor</h1>
                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Factor Id</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="buy.factor_id" type="number"/>
                            </div>
                        </div>
                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Total price</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="buy.total_price" type="text"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    name: "ManagerReport",
    data() {
      return {
        date: {
          year: null,
          month: null,
          day: null
        },
        report: null
      };
    },
    methods: {
      getData() {
        this.$http.get("http://127.0.0.1:9090/restaurant/report/" +
          this.date.year + "/" +
          this.date.month + "/" +
          this.date.day)
          .then(response => {
            this.report = response.data;
            console.log(this.report);
          });
      }
    }
  };
</script>

<style scoped>
    .container {
        border: 5px solid;
        margin-left: 25%;
        margin-right: 25%;
        padding-bottom: 10px;
        background: #64818c;
        border-radius: 4px;
        display: block;
        border-color: #64818c;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

    input[type="text"],
    input[type="number"],
    select,
    textarea {
        width: 50%;
        padding: 12px;
        border: 1px solid #c7d7d9;
        border-radius: 4px;
        resize: vertical;
    }

    .item {
        display: block;
        margin-top: 20px;
    }

    label {
        color: #c7d7d9;
        margin-top: 2px;
        font-size: 1rem;
        width: 20%;
    }

    input[type="button"] {
        width: 100%;
        background-color: #e9f1f2;
        color: #64818c;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
</style>