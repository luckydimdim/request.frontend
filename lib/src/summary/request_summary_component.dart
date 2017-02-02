import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-summary', templateUrl: 'request_summary_component.html')
class RequestSummaryComponent implements AfterViewInit {
  static const String route_name = 'RequestSummary';
  static const String route_path = 'summary';
  static const Route route = const Route(
      path: RequestSummaryComponent.route_path,
      component: RequestSummaryComponent,
      name: RequestSummaryComponent.route_name);

  final Router _router;

  RequestSummaryComponent(this._router) {}

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item active">Итого</li>
    ''';
  }

  @override
  void ngAfterViewInit() {
    breadcrumbInit();

    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
