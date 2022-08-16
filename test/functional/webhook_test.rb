require File.join(File.dirname(__FILE__), 'test_helper')

describe 'webhook' do
  let(:base_cmd) { %w[webhook] }
  let(:webhook) do
    {
      id: 1,
      name: 'test',
      target_url: 'https://app.example.com',
      enabled: true,
      event: 'user_created.event.foreman',
      http_method: 'POST',
      http_content_type: 'application/json',
      webhook_template: { id: 1, name: 'test' },
      user: 'admin',
      verify_ssl: true,
      proxy_authorization: true,
      ssl_ca_certs: 'certs',
      'http_headers' => '{"X-Shellhook-Arg-0":"test","X-Shellhook-Arg-1":"2"}',
      created_at: '01/10/2022',
      updated_at: '01/10/2022'
    }
  end

  describe 'list' do
    let(:cmd) { base_cmd << 'list' }

    it 'should list all webhooks' do
      api_expects(:webhooks, :index, 'List').with_params(
        'page' => 1, 'per_page' => 1000
      ).returns(index_response([webhook]))

      output = IndexMatcher.new(
        [
          ['ID', 'NAME',  'TARGET URL',              'ENABLED'],
          ['1',  'test',  'https://app.example.com', 'yes']
        ]
      )
      expected_result = success_result(output)

      result = run_cmd(cmd)
      assert_cmd(expected_result, result)
    end
  end

  describe 'create' do
    let(:cmd) { base_cmd << 'create' }
    let(:params) do
      %w[
        --name=test --target-url=https://app.example.com --enabled=true
        --event=user_created.event.foreman
        --http-headers=X-Shellhook-Arg-0=test,X-Shellhook-Arg-1=2
      ]
    end

    it 'should create a webhook' do
      api_expects(:webhooks, :create).with_params(
        'webhook' => {
          'target_url' => 'https://app.example.com', 'name' => 'test',
          'enabled' => true, 'event' => 'user_created.event.foreman',
          'http_headers' => '{"X-Shellhook-Arg-0":"test","X-Shellhook-Arg-1":"2"}'
        }
      ).returns(webhook)

      expected_result = success_result("Webhook [test] created.\n")

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end
  end

  describe 'update' do
    let(:cmd) { base_cmd << 'update' }
    let(:params) do
      %w[
        --id=1 --target-url=https://app.example.com --enabled=true
        --event=user_created.event.foreman
        --http-headers=X-Shellhook-Arg-0=test,X-Shellhook-Arg-1=2
      ]
    end

    it 'should update a webhook' do
      api_expects(:webhooks, :update).with_params(
        'id' => '1',
        'webhook' => {
          'target_url' => 'https://app.example.com',
          'enabled' => true, 'event' => 'user_created.event.foreman',
          'http_headers' => '{"X-Shellhook-Arg-0":"test","X-Shellhook-Arg-1":"2"}'
        }
      ).returns(webhook)

      expected_result = success_result("Webhook [test] updated.\n")

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end
  end

  describe 'info' do
    let(:cmd) { base_cmd << 'info' }
    let(:params) { %w[--id=1] }

    it 'should show a webhook' do
      api_expects(:webhooks, :show, 'Show').with_params('id' => '1').returns(webhook)

      expected_result = success_result(/X-Shellhook-Arg-0/)

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end
  end

  describe 'delete' do
    let(:cmd) { base_cmd << 'delete' }
    let(:params) { %w[--id=1] }

    it 'should delete a webhook' do
      api_expects(:webhooks, :destroy, 'Delete').with_params('id' => '1').returns(webhook)

      expected_result = success_result("Webhook [test] deleted.\n")

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end
  end
end
