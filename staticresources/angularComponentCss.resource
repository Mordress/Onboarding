.view-animate.ng-enter {
  transition:0.7s ease all;
  transform: translateY(30px);
  color: green;
}

.view-animate.ng-enter.ng-enter-active {
    transform: translateY(0);
    color:green;
}

.view-animate.ng-leave {
    transition:0.7s ease all;
    transform: translateY(0);
    color:green;
}

.view-animate.ng-leave.ng-leave-active {
    transform: translateY(30px);
    color: green;
}