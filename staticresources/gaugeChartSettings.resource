// gaugeChartSettings
var opts = {
    angle: 0, // The span of the gauge arc
    lineWidth: 0.2, // The line thickness
    radiusScale: 1, // Relative radius
    pointer: {
        length: 0.5, // // Relative to gauge radius
        strokeWidth: 0.02, // The thickness
        color: '#000000' // Fill color
    },
    limitMax: false,     // If false, max value increases automatically if value > maxValue
    limitMin: false,     // If true, the min value of the gauge will be fixed
    colorStart: '#6FADCF',   // Colors
    colorStop: '#8FC0DA',    // just experiment with them
    strokeColor: '#E0E0E0',  // to see which ones work best for you
    generateGradient: true,
    highDpiSupport: true,     // High resolution support
    renderTicks: {
        divisions: 10,
        divWidth: 1,
        divLength: 0.3,
        divColor: '#333333',
        subDivisions: 2,
        subLength: 0.15,
        subWidth: 0.5,
        subColor: '#666666'
    },
    staticZones: [
        {strokeStyle: "#F03E3E", min: 0, max: 33}, // Red
        {strokeStyle: "#FFDD00", min: 34, max: 66}, // Yellow
        {strokeStyle: "#30B32D", min: 67, max: 100}, // Green
    ],
    staticLabels: {
        font: "12px Salesforce Sans",  // Specifies font
        labels: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],  // Print labels at these values
        color: "#000000",  // Optional: Label text color
        fractionDigits: 0  // Optional: Numerical precision. 0=round off.
    }
};

function getGaugeOpt() {
    return opts;
}