=begin
  send formatted output directly to the HTTP response
  source : http://wiki.rubyonrails.org/rails/pages/HowtoExportDataAsCSV
  All this controller see the same scheme.
  For a model exported "me", you will have :
  def me :
    which explains will format will be supported and how
  def compute_me :
    which explains will datas will be exported in all of those formats
 All those export finishes with the call to #generate_report,
 which sets correct headers for the differents browser and send the file
=end
class ExportController < ApplicationController

  # return the contents of contributions in a table in ODS format
  # with Ruport :
  # We can export to other formats :
  # compute_contributions(:pdf) export to pdf
  def contracts
    respond_to do |format|
      format.html { redirect_to contracts_path }
      format.xml {
        # TODO : make an xml export : a finder +
        #  render :xml => @issues.to_xml should be enough)
      }
      format.ods { compute_contracts(:ods) }
    end
  end

  def compute_contracts(type)
    methods = [ 'contract_name', 'start_date_formatted', 'end_date_formatted',
      'users_size', 'releases_size', 'issues_size', 'tam_name',
      'salesman_name', 'pname_teams', 'pname_users' ]
    options = { :order => 'contracts.start_date ASC',
      :include => [:salesman, :tam],
      :joins => Contract::INNER_JOIN_TEAMS,
      :conditions => flash[:conditions],
      :methods => methods }

    report = Contract.report_table(:all, options)
    columns= [ 'id', 'contract_name', 'start_date_formatted', 'end_date_formatted',
      'users_size', 'releases_size', 'issues_size', 'tam_name',
      'salesman_name', 'pname_teams', 'pname_users' ]
    unless report.column_names.empty?
      report.reorder(columns)
      report.rename_columns columns,
        [ _('id'), _('contract'), _('start date'), _('end date'), _('users'),
          _('softwares'), _('issues'), _('tam'), _('salesman'), _('teams'),
          _('users') ]
    end
    generate_report(report, type, {})
  end



  # return the contents of contributions in a table in ODS format
  # with Ruport :
  # We can export to other formats :
  # compute_contributions(:pdf) export to pdf
  def contributions
    respond_to do |format|
      format.html { redirect_to contributions_path }
      format.xml {
        # TODO : make an xml export : a finder +
        #  render :xml => @issues.to_xml should be enough)
      }
      format.ods { compute_contributions(:ods) }
    end
  end

  def compute_contributions(type)
    methods = ['pname_contributiontype', 'pname_software', 'version_to_s',
      'pname_contributionstate', 'delay_in_words', 'clos_enhance',
      'contributed_on_formatted']
    options = { :order => 'contributions.contributed_on ASC',
      :include => [:software, :contributionstate, :issue],
      :conditions => flash[:conditions],
      :methods => methods }

    report = Contribution.report_table(:all, options)
    columns= [ 'id','pname_contributiontype', 'pname_software',
      'version_to_s','pname_contributionstate', 'synthesis',
      'contributed_on_formatted','clos_enhance','delay_in_words' ]
    unless report.column_names.empty?
      report.reorder(columns)
      report.rename_columns columns,
        [ _('id'), _('type'), _('software'), _('version'), _('state'),
          _('summary'), _('reported'), _('closed'), _('delay') ]
    end
    generate_report(report, type, {})
  end

  # return the contents of users in a table in ODS format
  # with Ruport
  def users
    respond_to do |format|
      format.html { redirect_to accounts_path }
      format.xml {
        # TODO : make an xml export : a finder +
        #  render :xml => @issues.to_xml should be enough)
      }
      format.ods { compute_users(:ods) }
    end
  end

  def compute_users(type)
    options = { :order => 'users.login', :include => [:role],
      :conditions => flash[:conditions],
      :methods => ['client_name', 'role_name']
    }
    report = User.report_table(:all, options)
    columns = ['id','login','name','email','telephone',
      'client_name', 'role_name']

    report.reorder columns
    report.rename_columns columns,
      [_('id'), _('login'), _('name'), _('e-mail'), _('phone'),
        _('(customer)'), _('roles') ]

    generate_report(report, type, {})
  end

  # with Ruport:
  def phonecalls
    respond_to do |format|
      format.html { redirect_to phonecalls_path }
      format.xml {
        # TODO : make an xml export : a finder +
        #  render :xml => @issues.to_xml should be enough)
      }
      format.ods { compute_phonecalls(:ods) }
    end
  end

  def compute_phonecalls(type)
    columns= ['contract_name', 'engineer_name', 'recipient_name']
    options = { :order => 'phonecalls.start', :include =>
      [:recipient,:engineer,:contract,:issue],
      :conditions => flash[:conditions],
      :methods => columns }
    report = Phonecall.report_table(:all, options)

    columns.push( 'start','end')
    unless report.column_names.empty?
      report.reorder columns
      report.rename_columns columns,
        [ _('Contract'), _('Owner'), _('Customer'), _('Call'),
          _('End of the call') ]
    end
    generate_report(report, type, {})
  end

  # return the contents of an issue in a table in  ods
  def issues
    respond_to do |format|
      format.html { redirect_to issues_path }
      format.xml {
        # TODO : make an xml export : a finder +
        #  render :xml => @issues.to_xml should be enough)
      }
      format.ods { compute_issues(:ods, {}) }
    end
  end

  def compute_issues(type, options_generate)
    columns = [ 'id', 'softwares_name', 'client_name', 'severities_name',
                'created_on_formatted', 'updated_on_formatted', 'resume',
                'statuts_name', 'issuetypes_name', 'expert_name',
                'last_comment_content', 'joined_tags'
              ]
    options= { :order => 'issues.created_on', :conditions => flash[:conditions],
      :select => Issue::SELECT_LIST + ', comments.text as last_comment_text',
      :joins => Issue::JOINS_LIST +
      ' INNER JOIN comments ON comments.id = issues.last_comment_id',
      :methods => columns
     }
    report = nil
    report = Issue.report_table(:all, options)
    unless report.column_names.empty?
      report.reorder columns
      report.rename_columns columns,
       [ _('Id'), _('Software'), _('Customer'), _('Severity'),
         _('Submission date'), _('Last update'), _('Summary'), _('Status'),
         _('Type'), _('Assigned to'), _('Last comment'), _('Tags') ]
    end

    generate_report(report, type, options_generate)
  end


  MIME_EXTENSION = {
    :text => [ '.txt', 'text/plain' ],
    :csv  => [ '.csv', 'text/csv' ],
    :pdf  => [ '.pdf', 'application/pdf' ],
    :html => [ '.html', 'text/html' ],
    :ods  => [ '.ods', 'application/vnd.oasis.opendocument.spreadsheet']
  }

  # Generate and upload a report to the user with a predefined name.
  #
  # Usage : generate_report(report, :csv) with report a Ruport Data Table
  def generate_report(report, type, options)
    #to keep the custom filters before the export :
    flash[:conditions] = flash[:conditions]
    file_extension = MIME_EXTENSION[type].first
    content_type = MIME_EXTENSION[type].last
    prefix = ( @session_user.recipient? ? @session_user.client.name : 'OSSA' )
    suffix = Time.now.strftime('%d_%m_%Y')
    filename = [ prefix, params[:action], suffix].join('_') + file_extension

     #this is required if you want this to work with IE
     if request.env['HTTP_USER_AGENT'] =~ /msie/i
       headers['Pragma'] = 'public'
       headers['Content-type'] = content_type
       headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
       headers['Content-Disposition'] = %Q{attachment; filename="#{filename}"}
       headers['Expires'] = "0"
     else
       headers["Content-type"] ||= content_type
       headers['Pragma'] = 'public'
       headers["Content-Disposition"] = %Q{attachment; filename="#{filename}"}
     end
    report_out = report.as(type, options)
    render(:text =>report_out , :layout => false)
  end


  private
  def repeat4times( row, element, decalage)
    4.times do |i|
      row << element[i+decalage].to_i
    end
  end

  # TODO : le mettre dans les utils ?
  def pname(object)
    (object ? object.name : '-')
  end

end
