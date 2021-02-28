defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores value by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)

    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete bucket by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "delete_me") == nil

    KV.Bucket.put(bucket, "delete_me", 4)

    assert KV.Bucket.delete(bucket, "delete_me") == 4

    assert KV.Bucket.get(bucket, "delete_me") == nil
  end
end
