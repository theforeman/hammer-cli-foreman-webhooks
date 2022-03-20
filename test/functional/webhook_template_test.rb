require File.join(File.dirname(__FILE__), 'test_helper')

describe 'webhook template' do
  describe 'import' do
    let(:template) do
      {
        'id' => 1,
        'template' => 'Template content'
      }
    end
    let(:cmd) { %w(webhook-template import) }
    let(:tempfile) { Tempfile.new('template') }

    it 'requires --name and --file' do
      params = ['--name=test']
      api_expects_no_call
      expected_result = usage_error_result(
        cmd,
        'Options --name, --file are required.',
        'Could not import the webhook template')
      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end

    it 'import template' do
      params = ['--name=test', "--file=#{tempfile.path}"]
      tempfile.write('Template content')
      tempfile.rewind
      api_expects(:webhook_templates, :import, 'Import webhook template').with_params(
        'webhook_template' => {
          'name' => 'test',
          'template' => 'Template content'
        }).returns(template)

      result = run_cmd(cmd + params)
      assert_cmd(success_result("Imported webhook template successfully.\n"), result)
    end
  end

  describe 'export' do
    let(:cmd) { %w(webhook-template export) }
    let(:tempfile) { Tempfile.new('template', '/tmp') }
    let(:params) { ['--id=1', '--path=/tmp'] }
    let(:template_response) do
      response = mock('TemplateResponse')
      response.stubs(:code).returns(200)
      response.stubs(:body).returns('Template content')
      response.stubs(:headers).returns({:content_disposition => "filename=\"#{File.basename(tempfile.path)}\""})
      response
    end

    it 'download template' do
      api_expects(:webhook_templates, :export, 'Export webhook template').with_params(
        'id' => '1').returns(template_response)

      output = OutputMatcher.new("The webhook template has been saved to #{tempfile.path}")
      expected_result = success_result(output)
      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
      assert_equal('Template content', tempfile.read)
    end
  end
end
