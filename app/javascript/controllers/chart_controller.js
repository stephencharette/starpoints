import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from 'chart.js';

export default class ChartController extends Controller {
  static ELEMENT_ID = 'hero-chart';
  static DEFAULT_OPTIONS = { 
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
  };

  connect() {
    Chart.register(...registerables);
    this.render();
  }

  render() {
    if (!this.ele) return;
   
    const ctx = this.ele.getContext('2d');

    this.graph = new Chart(ctx, { type: 'bar', data: this.data, options: this.options });
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
    // return this._labels = this._labels || this.metrics.map((m) => new Date(m.updated_at).toDateString());
    return this._labels = this._labels || this.metrics.map((m) => m[0]);
  }

  get datasets() {
    return [{
      // label: `${this.metric} / ${this.unit}`,
      // data: this.metrics.map((m) => parseInt(m.value, 10)),
      // data: this.metrics,
      data: [55.70, 21.49, 10.99, 41.05, 87.65],
      fill: false,
      // '#37B573', rgb(235,85,74)
      // rgb(55,181,115)
      backgroundColor: 'rgb(55,181,115)',
      tension: 0.1,
      maintainAspectRatio: false,
      borderRadius: 5,
      barThickness: 25,
      lineCap: 'round'
    }];
  }
}