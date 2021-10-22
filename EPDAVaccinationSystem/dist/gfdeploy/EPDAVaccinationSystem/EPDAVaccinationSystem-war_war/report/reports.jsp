<%-- 
    Document   : reports
    Created on : Oct 19, 2021, 6:02:30 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="utils.EnumState"%>
<%@page import="constants.ConstantSession"%>
<%@page import="constants.ConstantLink"%>
<%@page import="constants.ConstantMessage"%>
<%@page import="classes.AccountStatus"%>
<%@page import="classes.UserRole"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute(ConstantSession.UserCredentialRole) == null) {
        response.sendRedirect(ConstantLink.UrlLogin);
        return;
    }
    if (!session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
        response.sendRedirect(ConstantLink.UrlDashboard);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reports | EPDA Vaccination System</title>
        <link rel="icon" href="../assets/media/APU-Logo.png" type="image/x-icon">
        <!-- Mandatory CSS Library -->
        <link href="../assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="../assets/vendors/fontawesome-free/css/all.css" rel="stylesheet">
        <link href="../assets/css/style-bundle.css" rel="stylesheet">
        <link href="../assets/css/style-navbar.css" rel="stylesheet">
        <link href="../assets/css/style-sidebar.css" rel="stylesheet">

        <!-- Font Family -->
        <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:300,400,500,600,700&family=Poppins:300,400,500,600,700" rel="stylesheet">

        <!-- Optional CSS Library -->
        <link href="../assets/vendors/SweetAlert2/sweetalert2.min.css" rel="stylesheet">

        <!-- Mandatory JavaScript Library -->
        <script src="../assets/vendors/jquery/jquery.min.js"></script>
        <script src="../assets/vendors/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendors/jQuery-Validation/dist/jquery.validate.js"></script>
        <script src="../assets/js/script-bundle.js"></script>

        <!-- Optional JavaScript Library -->
        <script src="../assets/vendors/SweetAlert2/sweetalert2.all.min.js"></script>
        <script src="../assets/vendors/chartjs/chart.min.js"></script>
    </head>
    <body>
        <div class="wrapper">
            <!-- Begin: Top Navbar -->
            <jsp:include page="../layout/top-navbar.jsp" />
            <!-- End: Top Navbar -->
            <!-- Page Content -->
            <div class="main-content">
                <!-- Begin: Sidebar -->         
                <jsp:include page="../layout/sidebar.jsp" />
                <!-- End: Sidebar -->
                <div class="content">
                    <div class="header d-flex justify-content-between align-items-center mb-4 row">
                        <h2 class="font-weight-bold col-12">Reports</h2>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6">
                            <label class="col-form-label required" for="reportType">Report Type</label>
                            <label class="select-icon">
                                <select class="form-control" name="reportType" id="reportType">
                                    <option value="1">Vaccination Progress by State</option>
                                    <option value="2">Vaccination Progress by Gender</option>
                                    <option value="3">Vaccination Progress by Age Group</option>
                                    <option value="4">Distribution of Vaccinated People</option>
                                    <option value="5">Clinic Vaccination Capacity by State</option>
                                </select>
                            </label>
                        </div>
                    </div>
                    <div class="container-xl mt-5">
                        <div class="mb-5" id="reportType1">
                            <div class="bg-white shadow p-2">
                                <canvas id="vaccinationProgressByStateChart"></canvas>
                            </div>
                        </div>
                        <div class="mb-5" id="reportType2" style="display:none;">
                            <div class="bg-white shadow p-2 mb-5">
                                <canvas id="vaccinationProgressByGenderChart"></canvas>
                            </div>
                            <div class="bg-white shadow p-2 mb-5">
                                <canvas id="vaccinatedByGenderChart"></canvas>
                            </div>
                            <div class="bg-white shadow p-2">
                                <canvas id="distributionOfVaccinatedPeopleDailyByGenderChart"></canvas>
                            </div>
                        </div>
                        <div class="mb-5" id="reportType3" style="display:none;">
                            <div class="bg-white shadow p-2 mb-5">
                                <canvas id="vaccinationProgressByAgeGroupChart"></canvas>
                            </div>
                            <div class="bg-white shadow p-2">
                                <canvas id="distributionOfVaccinatedPeopleDailyByAgeGroupChart"></canvas>
                            </div>
                        </div>
                        <div class="mb-5" id="reportType4" style="display:none;">
                            <div class="bg-white shadow p-2">
                                <canvas id="distributionOfVaccinatedPeopleDailyChart"></canvas>
                            </div>
                        </div>
                        <div class="mb-5" id="reportType5" style="display:none;">
                            <div class="bg-white shadow p-2">
                                <canvas id="clinicCapacityChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <!-- Begin: Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End: Footer -->
                </div>
            </div>
        </div>
    </body>
    <script>
        $(function () {
            var ctx1 = document.getElementById('vaccinationProgressByStateChart').getContext('2d');
            var vaccinationProgressByStateChart = new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Vaccinated',
                            data: [],
                            backgroundColor: '#0fc939',
                            order: 1,
                        },
                        {
                            label: 'Registered',
                            data: [],
                            backgroundColor: '#3b82f6',
                            order: 2,
                        },
                        {
                            label: 'Vaccinated',
                            data: [],
                            borderColor: '#5CB85C',
                            backgroundColor: 'green',
                            type: 'line',
                            order: 0
                        }
                    ]
                },
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: 'Vaccination Progress by State',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    if (label === 'Registered') {
                                        var total = context.parsed.y + vaccinationProgressByStateChart.data.datasets[0].data[context.dataIndex];
                                        return label + ': ' + total;
                                    }
                                    return label + ': ' + context.parsed.y;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'State',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            }
                        },
                        y: {
                            beginAtZero: true,
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Number of People',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            },
                            ticks: {
                                precision: 0
                            }
                        },
                    },
                }
            });

            var ctx2 = document.getElementById('vaccinationProgressByGenderChart').getContext('2d');
            var vaccinationProgressByGenderChart = new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Vaccinated',
                            data: [],
                            backgroundColor: '#0fc939',
                            order: 1,
                        },
                        {
                            label: 'Registered',
                            data: [],
                            backgroundColor: '#3b82f6',
                            order: 2,
                        }
                    ]
                },
                options: {
                    indexAxis: 'y',
                    elements: {
                        bar: {
                            borderWidth: 2,
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Vaccination Progress by Gender',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        legend: {
                            position: 'right'
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    if (label === 'Registered') {
                                        var total = context.parsed.x + vaccinationProgressByGenderChart.data.datasets[0].data[context.dataIndex];
                                        return label + ': ' + total;
                                    }
                                    return label + ': ' + context.parsed.x;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Number of People',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            },
                            ticks: {
                                precision: 0
                            }
                        },
                        y: {
                            beginAtZero: true,
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Gender',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            }
                        },
                    },
                }
            });

            var ctx2a = document.getElementById('vaccinatedByGenderChart').getContext('2d');
            var vaccinatedByGenderChart = new Chart(ctx2a, {
                type: 'doughnut',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Vaccinated',
                            data: [],
                            backgroundColor: ['#3b82f6', '#fb4069', '#8e8e8e']
                        }
                    ]
                },
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: 'Vaccinated by Gender',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        legend: {
                            position: 'top'
                        }
                    },
                }
            });

            var ctx2b = document.getElementById('distributionOfVaccinatedPeopleDailyByGenderChart').getContext('2d');
            var distributionOfVaccinatedPeopleDailyByGenderChart = new Chart(ctx2b, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'All',
                            data: [],
                            backgroundColor: '#5CB85C',
                            borderColor: '#5CB85C',
                            borderDash: [12, 6],
                        },
                        {
                            label: 'Male',
                            data: [],
                            backgroundColor: '#3b82f6',
                            borderColor: '#3b82f6',
                        },
                        {
                            label: 'Female',
                            data: [],
                            backgroundColor: '#fb4069',
                            borderColor: '#fb4069',
                        },
                        {
                            label: 'Unspecified',
                            data: [],
                            backgroundColor: '#8e8e8e',
                            borderColor: '#8e8e8e',
                        }
                    ]
                },
                options: {
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    elements: {
                        point: {
                            radius: 0
                        }
                    },
                    stacked: true,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Distribution of Vaccinated People By Gender (Per day)',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    return label + ': ' + context.parsed.y;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Date',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            },
                            grid: {
                                display: false,
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Number of People',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            },
                            ticks: {
                                precision: 0
                            },
                            grid: {
                                borderDash: [12, 10],
                            }
                        },
                    },
                }
            });

            var ctx3 = document.getElementById('vaccinationProgressByAgeGroupChart').getContext('2d');
            var vaccinationProgressByAgeGroupChart = new Chart(ctx3, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Vaccinated',
                            data: [],
                            backgroundColor: '#0fc939',
                            order: 1,
                        },
                        {
                            label: 'Registered',
                            data: [],
                            backgroundColor: '#3b82f6',
                            order: 2,
                        }
                    ]
                },
                options: {
                    indexAxis: 'y',
                    elements: {
                        bar: {
                            borderWidth: 2,
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Vaccination Progress by Age Group',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        legend: {
                            position: 'right'
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    if (label === 'Registered') {
                                        var total = context.parsed.x + vaccinationProgressByAgeGroupChart.data.datasets[0].data[context.dataIndex];
                                        return label + ': ' + total;
                                    }
                                    return label + ': ' + context.parsed.x;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Number of People',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            },
                            ticks: {
                                precision: 0
                            }
                        },
                        y: {
                            beginAtZero: true,
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Age Group',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            }
                        },
                    },
                }
            });

            var ctx3a = document.getElementById('distributionOfVaccinatedPeopleDailyByAgeGroupChart').getContext('2d');
            var distributionOfVaccinatedPeopleDailyByAgeGroupChart = new Chart(ctx3a, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'All Age Group',
                            data: [],
                            backgroundColor: '#5CB85C',
                            borderColor: '#5CB85C',
                            borderDash: [12, 6],
                        },
                        {
                            label: '12 to 17',
                            data: [],
                            backgroundColor: '#b3c0fa',
                            borderColor: '#b3c0fa',
                        },
                        {
                            label: '18 to 24',
                            data: [],
                            backgroundColor: '#f2d42c',
                            borderColor: '#f2d42c',
                        },
                        {
                            label: '25 to 34',
                            data: [],
                            backgroundColor: '#ff3f00',
                            borderColor: '#ff3f00',
                        },
                        {
                            label: '35 to 54',
                            data: [],
                            backgroundColor: '#ff00d0',
                            borderColor: '#ff00d0',
                        },
                        {
                            label: '55+',
                            data: [],
                            backgroundColor: '#1400ff',
                            borderColor: '#1400ff',
                        }
                    ]
                },
                options: {
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    elements: {
                        point: {
                            radius: 0
                        }
                    },
                    stacked: true,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Distribution of Vaccinated People By Age Group (Per day)',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    return label + ': ' + context.parsed.y;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Date',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            },
                            grid: {
                                display: false,
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Number of People',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            },
                            ticks: {
                                precision: 0
                            },
                            grid: {
                                borderDash: [12, 10],
                            }
                        },
                    },
                }
            });

            var ctx4 = document.getElementById('distributionOfVaccinatedPeopleDailyChart').getContext('2d');
            var distributionOfVaccinatedPeopleDailyChart = new Chart(ctx4, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Vaccinated',
                            data: [],
                            backgroundColor: '#5CB85C',
                            borderColor: '#5CB85C'
                        }
                    ]
                },
                options: {
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    elements: {
                        point: {
                            radius: 0
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Distribution of Vaccinated People (Per day)',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    return label + ': ' + context.parsed.y;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Date',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            },
                            grid: {
                                display: false,
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Number of People',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            },
                            ticks: {
                                precision: 0
                            },
                            grid: {
                                borderDash: [12, 10],
                            }
                        },
                    },
                }
            });

            var ctx5 = document.getElementById('clinicCapacityChart').getContext('2d');
            var clinicCapacityChart = new Chart(ctx5, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Clinic Vaccination Capacity (Per day)',
                            data: [],
                            backgroundColor: '#5CB85C',
                            borderColor: '#5CB85C'
                        }
                    ]
                },
                options: {
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    elements: {
                        point: {
                            radius: 0
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Clinic Vaccination Capacity by State',
                            color: 'black',
                            font: {
                                size: 28,
                                weight: 'bold'
                            }
                        },
                        subtitle: {
                            display: true,
                            text: 'Data for all time',
                            color: '#6b7280',
                            font: {
                                size: 16,
                                family: 'tahoma',
                            },
                            padding: {
                                bottom: 10
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context, obj) {
                                    var label = context.dataset.label || "";
                                    return label + ': ' + context.parsed.y;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'State',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2,
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 5}
                            },
                            grid: {
                                display: false,
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Vaccination Capacity (People)',
                                color: '#1f2937',
                                font: {
                                    size: 20,
                                    weight: 'bold',
                                    lineHeight: 1.2
                                },
                                padding: {top: 15, left: 0, right: 0, bottom: 0}
                            },
                            ticks: {
                                precision: 0
                            },
                            grid: {
                                borderDash: [12, 10],
                            }
                        },
                    },
                }
            });

            loadChartDataVaccinationProgressByState(vaccinationProgressByStateChart, "../APIReportVaccinationProgressPerState");
            loadChartDataVaccinationProgressByGender(vaccinationProgressByGenderChart, "../APIReportVaccinationProgressByGender");
            loadChartDataVaccinatedByGender(vaccinatedByGenderChart, "../APIReportVaccinationProgressByGender");
            loadChartDataDistributionOfVaccinatedPeopleDailyByGender(distributionOfVaccinatedPeopleDailyByGenderChart, "../APIReportDistributionOfVaccinatedPeopleDailyByGender");
            loadChartDataVaccinationProgressByAgeGroup(vaccinationProgressByAgeGroupChart, "../APIReportVaccinationProgressByAgeGroup");
            loadChartDataDistributionOfVaccinatedPeopleDailyByAgeGroup(distributionOfVaccinatedPeopleDailyByAgeGroupChart, "../APIReportDistributionOfVaccinatedPeopleDailyByAgeGroup");
            loadChartDataDistributionOfVaccinatedPeopleDaily(distributionOfVaccinatedPeopleDailyChart, "../APIReportDistributionOfVaccinatedPeopleDaily");
            loadChartDataClinicCapacityChart(clinicCapacityChart, "../APIReportClinicCapacity");
        });

        $('#reportType').change(function () {
            var choice = $(this).val();
            if (choice === '1') {
                $('#reportType2, #reportType3, #reportType4, #reportType5').hide();
                $('#reportType1').show();
            } else if (choice === '2') {
                $('#reportType1, #reportType3, #reportType4, #reportType5').hide();
                $('#reportType2').show();
            } else if (choice === '3') {
                $('#reportType1, #reportType2, #reportType4, #reportType5').hide();
                $('#reportType3').show();
            } else if (choice === '4') {
                $('#reportType1, #reportType2, #reportType3, #reportType5').hide();
                $('#reportType4').show();
            } else if (choice === '5') {
                $('#reportType1, #reportType2, #reportType3, #reportType4').hide();
                $('#reportType5').show();
            }
        });

        function loadChartDataVaccinationProgressByState(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.data.datasets[1].data = response.registered;
                chart.data.datasets[2].data = response.vaccinated;
                chart.update();
            });
        }

        function loadChartDataVaccinationProgressByGender(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.data.datasets[1].data = response.registered;
                chart.update();
            });
        }

        function loadChartDataVaccinatedByGender(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.update();
            });
        }

        function loadChartDataDistributionOfVaccinatedPeopleDailyByGender(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.data.datasets[1].data = response.vaccinatedMale;
                chart.data.datasets[2].data = response.vaccinatedFemale;
                chart.data.datasets[3].data = response.vaccinatedUnspecified;
                chart.update();
            });
        }

        function loadChartDataVaccinationProgressByAgeGroup(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.data.datasets[1].data = response.registered;
                chart.update();
            });
        }

        function loadChartDataDistributionOfVaccinatedPeopleDailyByAgeGroup(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.data.datasets[1].data = response.Age12_17;
                chart.data.datasets[2].data = response.Age18_24;
                chart.data.datasets[3].data = response.Age25_34;
                chart.data.datasets[4].data = response.Age35_54;
                chart.data.datasets[5].data = response.Age55_Above;
                chart.update();
            });
        }

        function loadChartDataDistributionOfVaccinatedPeopleDaily(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.vaccinated;
                chart.update();
            });
        }
        
        function loadChartDataClinicCapacityChart(chart, url) {
            var data = {};
            $.getJSON(url, data).done(function (response) {
                chart.data.labels = response.labels;
                chart.data.datasets[0].data = response.capacity;
                chart.update();
            });
        }
    </script>
</html>


