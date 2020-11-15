class AppComponent < ViewComponentReflex::ContextComponent::AppComponent
  layout Dashboard::LayoutComponent

  routes '/properties' => Properties::IndexComponent,
         '/' => Properties::IndexComponent,
         '/customers' => Properties::IndexComponent,
         '/inbox' => Properties::IndexComponent,
         '/users' => Properties::IndexComponent,
         '/contracts' => Properties::IndexComponent,
         '/rents' => Properties::IndexComponent,
         '/profile' => Properties::IndexComponent,
         '/organization' => Properties::IndexComponent
end
