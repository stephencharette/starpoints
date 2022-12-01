import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from 'chart.js';
import Rails from '@rails/ujs';

let graph = null;

export default class ChartController extends Controller {
  static ELEMENT_ID = 'hero-chart'
  static targets = [ "title", "spending" ]
  static DEFAULT_OPTIONS = { 
    animation: {
      duration: 600
    },
    responsive: true, maintainAspectRatio: false,
    plugins: {
      legend: {
        display: false
      }
    },
    scales: {
      x: {
        grid: {
          display: false
        }
      },
      y: {
        beginAtZero: true,
        position: 'right',
        ticks: {
          stepSize: 20,
          font: {
            size: 12
          },
          callback: function(value, index, ticks) {
              return '$' + value;
          }
        }
      }
    }
  }

  initialize() {
    this.tab = 'month'
    this.current_date = new Date(document.querySelector('[data-current-datetime]').dataset.currentDatetime)
  }

  async updateGraph(data) {
    if(data == null) {
      this.spendingTarget.textContent = '$0'  
      graph.data.datasets[0].data = null
      graph.config.data.labels = []
    }
    else {
      data = [].concat(data)
      graph.data.datasets[0].data = data.map((m) => m[1])
      graph.config.data.labels = data.map((m) => m[0])
      this.spendingTarget.textContent = "$" + data.map((m) => parseFloat(m[1])).reduce((partialSum, a) => partialSum + a, 0).toFixed(2);
    }

    graph.update()
  }

  async left() {
    this.nextDirection = 0
    this.next()
  }

  async right() {
    this.nextDirection = 1
    this.next()
  }

  async next() {
    let newText = null;
    switch(this.tab) {
      case 'week':
        let day = this.current_date.getDay()
        if(this.nextDirection == 0)
          this.current_date.setDate(this.current_date.getDate() - 7 - day);  
        else this.current_date.setDate(this.current_date.getDate() + 7 - day);

        let firstDate = this.current_date.toLocaleString('default', { day: '2-digit', month: 'short' })
        let secondDate = new Date(this.current_date)
        secondDate = new Date(secondDate.setDate(secondDate.getDate() + 7)).toLocaleString('default', { day: '2-digit', month: 'short' });

        newText = firstDate + ' — ' + secondDate;
        break;
      case 'month':
        if(this.nextDirection == 0)
          this.current_date.setMonth(this.current_date.getMonth() - 1);
        else this.current_date.setMonth(this.current_date.getMonth() + 1);

        newText = this.current_date.toLocaleString('default', { month: 'long', year: 'numeric' });
        break;
      case 'year':
        if(this.nextDirection == 0)
        this.current_date.setFullYear(this.current_date.getFullYear() - 1);  
        else this.current_date.setFullYear(this.current_date.getFullYear() + 1);
        
        newText = this.current_date.toLocaleString('default', { year: 'numeric' });
        break;
    }

    this.titleTarget.textContent = newText;
    const response = await fetch('/?timeframe=' + this.tab + '&starting_date=' + this.current_date, 
                                 { method: 'GET', headers: { accept: "application/json" } })
    let data = await response.json()
    this.updateGraph(data)
  }

  async week() {
    this.tab = 'week'
    this.titleTarget.textContent = this.titleTarget.dataset.titleWeek
    const response = await fetch('/?timeframe=week', 
                                 { method: 'GET', headers: { accept: "application/json" } })
    let data = await response.json()
    this.updateGraph(data)
  }

  async month() {
    this.tab = 'month'
    this.titleTarget.textContent = this.titleTarget.dataset.titleMonth
    const response = await fetch('/?timeframe=month', 
                                 { method: 'GET', headers: { accept: "application/json" } })
    let data = await response.json()
    this.updateGraph(data)
  }

  async year() {
    this.tab = 'year'
    this.titleTarget.textContent = this.titleTarget.dataset.titleYear
    const response = await fetch('/?timeframe=year', 
                                 { method: 'GET', headers: { accept: "application/json" } })
    let data = await response.json()
    this.updateGraph(data)
  }

  connect() {
    this.titleTarget.textContent = this.titleTarget.dataset.titleMonth

    Chart.register(...registerables);
    this.render();

    if(this._metrics == null) this.spendingTarget.textContent = '$0'
    else this.spendingTarget.textContent = "$" + this.metrics.map((m) => parseFloat(m[1])).reduce((partialSum, a) => partialSum + a, 0).toFixed(2);
  }

  render() {
    if (!this.ele) return;
   
    const ctx = this.ele.getContext('2d');

    graph = new Chart(ctx, { type: 'bar', data: this.data, options: this.options });
  }

  get ele() {
    return this._ele = this._ele || document.getElementById(ChartController.ELEMENT_ID);
  }

  get metric() {
    return this._metric = this._metric || this.element.dataset.metric;
  }

  get unit() {
    return this._unit = this._unit || this.element.dataset.unit;
  }

  get metrics() {
    return this._metrics = this._metrics || JSON.parse(document.querySelector('[data-metrics]').dataset.metrics);
  }

  get options() {
    return ChartController.DEFAULT_OPTIONS;
  }

  get data() {
    return { labels: this.labels, datasets: this.datasets };
  }

  get labels() {
    if(this.metrics == null) return null;
    return this._labels = this._labels || this.metrics.map((m) => m[0]);
  }

  get datasets() {
    let metricsData = this.metrics == null ? null : this.metrics.map((m) => m[1])

    return [{
      data: metricsData,
      fill: false,
      backgroundColor: 'rgb(55,181,115)',
      tension: 0.1,
      maintainAspectRatio: false,
      borderRadius: 5,
      barThickness: 25,
      lineCap: 'round'
    }];
  }
}